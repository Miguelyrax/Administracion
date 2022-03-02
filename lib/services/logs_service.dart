
import 'dart:convert';

import 'package:administracion/model/log_model.dart';
import 'package:administracion/model/logsResponse_model.dart';
import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LogsService with ChangeNotifier {
  final String baseURL = 'http://localhost:8080/api';
  final pref = PreferenciasUsuario();
  List<Log> listaLogs = [];
  
  Future<List<Log>> logs() async{
    final url = Uri.parse('$baseURL/logs');
    final token = pref.token;
    final resp = await http.get(url,headers: {'x-token': token});
    final logsResponse = logsResponseFromJson(resp.body);
    listaLogs = logsResponse.logs;
    notifyListeners();
    return logsResponse.logs;

  }
  Future<bool> newLog(log)async{
    final data = {
      'log':log
    };
    final url = Uri.parse('$baseURL/logs/new');
    final token = pref.token;
    final resp = await http.post(
      url,
      headers: {
        'Content-type':'application/json',
        'x-token':token
      },
      body: jsonEncode(data));

      print(resp.body);
      return true;
    }
}