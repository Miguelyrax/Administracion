import 'package:administracion/services/authservice.dart';
import 'package:administracion/services/logs_service.dart';
import 'package:administracion/services/socket_service.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:administracion/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nombreController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuarioService = Provider.of<UsuarioService>(context);
    final logsService =  Provider.of<LogsService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 20, right: 20 ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage('https://static-cse.canva.com/blob/211930/59-50-logotipos-que-te-inspiraran.png'),
              ),
              Text('LOGIN', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
              SizedBox(height: 40,),
              Input(texto: 'Usuario', icono: FontAwesomeIcons.user,txtController: nombreController,),
              SizedBox(height: 40,),
              Input(hint: true,texto: 'password', icono: FontAwesomeIcons.lock,txtController: passwordController,),
              SizedBox(height: 30,),
              ElevatedButton(
                
                    onPressed: ()async{
                        
                        final resp = await authService.login(nombreController.text, passwordController.text);
                        if(resp){
                          socketService.connect();
                          usuarioService.getUsuarios();
                          logsService.logs();
                          Navigator.pushReplacementNamed(context, '/');
                    }
  },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20,),
                  child: Center(child: Text('Ingresar', style: TextStyle(fontSize: 20),)),
                ))
            ],
          ),
        ),
      )
   );
  }

}