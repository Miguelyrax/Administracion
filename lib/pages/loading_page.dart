import 'package:administracion/pages/login_page.dart';
import 'package:administracion/pages/menu_page.dart';
import 'package:administracion/services/authservice.dart';
import 'package:administracion/services/logs_service.dart';
import 'package:administracion/services/socket_service.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checking(context),
        builder: (context,  snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
   );
  }

  Future checking(BuildContext context) async{
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    final logsService =  Provider.of<LogsService>(context);
    final resp = await authService.isLogin();

    if(resp){
      socketService.connect();
      usuarioService.getUsuarios();
      logsService.logs();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_,__,___)=>MenuPage(),
        transitionDuration: Duration(milliseconds: 0))
        );
    }else{
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_,__,___)=>LoginPage(),
        transitionDuration: Duration(milliseconds: 0))
        );
    }
  }
}