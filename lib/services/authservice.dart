

import 'dart:convert';

import 'package:administracion/helpers/environment.dart';
import 'package:administracion/model/login_model.dart';
import 'package:administracion/model/usuario_model.dart';
import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;


class AuthService with ChangeNotifier{
    Usuario usuario;
    final _prefs = PreferenciasUsuario();
    Future<bool> login(usuario,password) async{
      final data = {
        'email':usuario,
        'password':password
      };
      final url = Uri.parse('${Environment.baseURL}/auth/');
      final resp = await http.post(url, headers: {'Content-type':'application/json'}, body: jsonEncode(data));

      if(resp.statusCode == 200){
        final loginResponse = loginResponseFromJson(resp.body);
        this.usuario = loginResponse.usuario;
        if(loginResponse.ok){
          
          _prefs.token = loginResponse.token; 
          
          return true;
        }else{
          return false;
        }
      }else{
        return false;
      }
    }
    
    Future<bool> isLogin()async{
      final token = _prefs.token;
      final url = Uri.parse('${Environment.baseURL}/auth/renew');
      final resp = await http.get(
        url,
        headers: {
          'Content-type':'application/json',
          'x-token':token
        });
      if(resp.statusCode == 201){
        final authResponse = loginResponseFromJson(resp.body);
        this.usuario = authResponse.usuario;
        return true;
      }else{
        return false;
      }  
    }
}