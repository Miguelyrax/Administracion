import 'package:administracion/services/logs_service.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:administracion/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

  final log = LogsService();
  final user = UsuarioService();

void alert (BuildContext context, nombreController, passwordController,  usuarioController ,emailController, getUsuarios, edit, id){
  showDialog(barrierDismissible: true,context: context, builder: (context) {
      return AlertDialog(

        title: Text('Agregar usuario'),
        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
          
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Input(texto: 'Nombre', icono: FontAwesomeIcons.textHeight, txtController: nombreController,),
                SizedBox(height: 20,),
                Input(texto: 'Email', icono: FontAwesomeIcons.envelope, txtController: emailController,),
                SizedBox(height: 20,),
                Input(texto: 'Usuario', icono: FontAwesomeIcons.user, txtController: usuarioController,),
                SizedBox(height: 20,),
                Input(texto: 'Password', icono: FontAwesomeIcons.lock, txtController: passwordController, hint: true,),
                
                  
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    (edit) ?
                    ElevatedButton(
                    onPressed: ()async{
                     
                      final resp = await user.editUsuario(nombreController.text, emailController.text ,passwordController.text, id );
                      if(resp){
                        getUsuarios();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Guardar'))
                    
                    : ElevatedButton(
                    onPressed: ()async{
                     
                      final resp = await user.newUsuario(nombreController.text, usuarioController.text,  emailController.text ,passwordController.text);
                      if(resp){
                        getUsuarios();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Aceptar')),
                    ElevatedButton(
                    onPressed: (){},
                    child: Text('Cancelar')),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
}
void alertLog (BuildContext context, textController, getlogs){
  showDialog(barrierDismissible: true,context: context, builder: (context) {
      return AlertDialog(

        content: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Log', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                Input(texto: 'Log', icono: FontAwesomeIcons.bookOpen, txtController: textController, line: 20,),
               ElevatedButton(
                    onPressed: ()async{
                      final resp = await log.newLog(textController.text);
                      if(resp){
                        getlogs();
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Aceptar')),
          
                  
               
                
              ],
            ),
          ),
        ),
      );
    });
}




