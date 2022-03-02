import 'dart:convert';

import 'package:administracion/model/usuario_model.dart';
import 'package:administracion/model/usuario_response.dart';
import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final String baseURL = 'http://localhost:8080/api';
class UsuarioService with ChangeNotifier{

  List<Usuario> usuarios = [];
 
  Future<List<Usuario>> getUsuarios()async{
    final url = Uri.parse('$baseURL/usuarios/');
    final resp = await http.get(url,headers: {'Content-type':'application/json'});

    final usuariosResponse = usuarioResponseFromJson(resp.body);

    this.usuarios = usuariosResponse.usuarios;
  notifyListeners();
    return usuariosResponse.usuarios;
  }

  Future<bool> newUsuario(nombre,usuario,email,password )async{
    final prefs = PreferenciasUsuario();
    final token = prefs.token; 
    final data = {
      "nombre":nombre,
      "usuario":usuario,
      "email":email,
      "password":password,
      "role":"USER-ROLE"
    };
    final url = Uri.parse('$baseURL/usuarios/');
    final resp = await http.post(url, headers: {'Content-type':'application/json','x-token':token}, body: jsonEncode(data));
    print(resp.body);
    if(resp.statusCode == 201){

    return true;
    }
    return false;
    
  }
  Future<bool> editRole(role,id )async{
    final prefs = PreferenciasUsuario();
    final token = prefs.token; 
    final data = {
      "role":role,
    };
    final url = Uri.parse('$baseURL/usuarios/$id');
    final resp = await http.put(url, headers: {'Content-type':'application/json','x-token':token}, body: jsonEncode(data));
    print(resp.body);
    if(resp.statusCode == 201){

    return true;
    }
    return false;
    
  }
  Future<bool> editUsuario(nombre,email,password,id )async{
    final prefs = PreferenciasUsuario();
    final token = prefs.token; 
    final data = {
      "nombre":nombre,
      "email":email,
      "password":password
    };
    final url = Uri.parse('$baseURL/usuarios/$id');
    final resp = await http.put(url, headers: {'Content-type':'application/json','x-token':token}, body: jsonEncode(data));
    print(resp.body);
    if(resp.statusCode == 201){

    return true;
    }
    return false;
    
  }
}