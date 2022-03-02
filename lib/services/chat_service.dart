

import 'package:administracion/helpers/environment.dart';
import 'package:administracion/model/usuario_model.dart';
import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:administracion/services/mensajes_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier {

  Usuario usuario;

    Future<List<Mensaje>> getUsuarios(id)async{
      final _prefs = PreferenciasUsuario();
      final url =  Uri.parse('${Environment.baseURL}/mensajes/$id');
      final resp = await http.get(url, headers: {
        'Content-type':'application/json',
        'x-token': _prefs.token
      });
    

      final mensajesResponse = mensajesResponseFromJson(resp.body);

      return mensajesResponse.mensajes;
    }

}