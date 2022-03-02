import 'package:administracion/preferences/preferencias_usuario.dart';


import 'package:administracion/widgets/btn.dart';
import 'package:administracion/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';




class MenuPage extends StatelessWidget {
final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
     backgroundColor: (prefs.colorSecundario) ? Colors.black : Colors.white ,
      body:Stack(
        children: [
          ListView(
            physics: BouncingScrollPhysics(),
            children: [
          SizedBox(height: 150,),
          GestureDetector(onTap: ()=>Navigator.pushNamed(context, 'option', arguments: {}),child: BTN(color1:Color(0xff833471) , titulo: 'Configuración', color2:Color(0xffB53471) , icon: FontAwesomeIcons.cog,)),
          GestureDetector(onTap: ()=>Navigator.pushNamed(context, 'user', arguments: {}),child: BTN(color2:Color(0xffA3CB38) , titulo: 'Usuarios', color1:Color(0xff009432) , icon: FontAwesomeIcons.user,)),
          GestureDetector(onTap: ()=>Navigator.pushNamed(context, 'logs', arguments: {}),child: BTN(color1:Color(0xff1B1464) , titulo: 'Logs', color2:Color(0xff0652DD) , icon: FontAwesomeIcons.book,)),
          GestureDetector(onTap: ()=>Navigator.pushNamed(context, 'admin', arguments: {}),child: BTN(color1:Color(0xffEE5A24) , titulo: 'Administracion', color2:Color(0xffF79F1F) , icon: FontAwesomeIcons.unlock,)),
          GestureDetector(onTap: ()=>Navigator.pushNamed(context, 'chat', arguments: {}),child: BTN(color1:Color(0xffD980FA) , titulo: 'Chat', color2:Color(0xffFDA7DF) , icon: FontAwesomeIcons.facebookMessenger,)),
          
            ],
          ),
          CustomAppBar(color: (prefs.colorSecundario) ? Colors.white : Colors.black,),
          
          
        ],
      )
   );
  }
}

