import 'package:administracion/helpers/environment.dart';
import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;



  void connect() {
    print('qwui');
    final _prefs = PreferenciasUsuario();
    final token = _prefs.token;
    
    // Dart client
    this._socket = IO.io(Environment.socketURL, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew':true,
      'extraHeaders': {
        'x-token':token
      }
    });

    this._socket.on('connect', (_) {
      print('conectado');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

  }

  void disconnect(){
    this._socket.disconnect();
  }

}