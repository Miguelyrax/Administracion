import 'package:administracion/pages/chat_page.dart';
import 'package:administracion/pages/loading_page.dart';
import 'package:administracion/pages/login_page.dart';
import 'package:administracion/pages/logs_page.dart';
import 'package:administracion/pages/mensajes_page.dart';
import 'package:administracion/pages/menu_page.dart';
import 'package:administracion/pages/option_page.dart';
import 'package:administracion/pages/usuario_page.dart';
import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:administracion/services/authservice.dart';
import 'package:administracion/services/chat_service.dart';
import 'package:administracion/services/logs_service.dart';
import 'package:administracion/services/socket_service.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/administracion_page.dart';
 
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (BuildContext context) =>AuthService(),),
        ChangeNotifierProvider(create: (BuildContext context) =>SocketService(),),
        ChangeNotifierProvider(create: (BuildContext context) =>UsuarioService(),),
        ChangeNotifierProvider(create: (BuildContext context) =>ChatService(),),
        ChangeNotifierProvider(create: (BuildContext context) =>LogsService(),),
      ],
      child: MaterialApp(
        
        title: 'Material App',
        initialRoute: 'loading',
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : ( _ ) => MenuPage(),
          'option' : ( _ ) => OptionPage(),
          'user' : ( _ ) => UsuarioPage(),
          'logs' : ( _ ) => LogsPage(),
          'admin' : ( _ ) => AdminPage(),
          'login' : ( _ ) => LoginPage(),
          'chat' : ( _ ) => ChatPage(),
          'mensajes' : ( _ ) => MensajesPage(),
          'loading' : ( _ ) => LoadingPage(),
      
        },
      ),
    );
  }
}