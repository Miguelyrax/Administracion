import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:administracion/services/authservice.dart';
import 'package:administracion/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
class Header extends StatelessWidget {
  final String titulo;
  final Color color1;
  final Color color2;
  final Color colorSombra;
  final IconData icono;
  const Header({
    this.titulo, this.color1, this.color2, this.icono, this.colorSombra = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(tag: this.titulo,child: Cabezera(colorSombra: this.colorSombra, color1: this.color1,color2: this.color2,)),
        Positioned(right: 20, top: 30,child: GestureDetector(onTap: ()=>Navigator.pushReplacementNamed(context,'/'),child: FaIcon(FontAwesomeIcons.arrowAltCircleLeft, color: Colors.white,))),
        Positioned(
          top: -20,
          left: -20,
          child: FaIcon(this.icono,color: Colors.white10, size: 190,)),
        Column(
          children: [
            SizedBox(width: double.infinity,),
            SizedBox(height: 80,),
            Text('You´ve request for', style: TextStyle(color: Colors.white60, fontSize: 15),),
            SizedBox(height: 10,),
            Text(this.titulo, style: TextStyle(color: Colors.white, fontSize: 20),),
            SizedBox(height: 10,),
            FaIcon(this.icono, color: Colors.white,size: 100,)
            
          ],
        )  
      ],
    );
  }
}

class Cabezera extends StatelessWidget {
  final Color color1;
  final Color color2;
  final Color colorSombra;
  const Cabezera({
   this.color1, this.color2, this.colorSombra,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            this.color1,
            this.color2,
          ]
        ),
        boxShadow: [
          BoxShadow(
            color: this.colorSombra.withOpacity(0.2),
            blurRadius: 9,
            spreadRadius: 9
          )
        ]
      ),
    );
  }
}
class CustomAppBar extends StatelessWidget {
  final Color color;
  const CustomAppBar({
    Key key, this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final authService = Provider.of<AuthService>(context);
     final socketService = Provider.of<SocketService>(context ,listen: false);
     final _prefs = PreferenciasUsuario();
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2
          )]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Container(
            width: double.infinity,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('MJI', style: TextStyle(color: this.color, fontSize: 30, fontWeight: FontWeight.bold),),
                Container(
                  child: Row(
                    children: [
                CircleAvatar(backgroundColor: Colors.blueAccent,child: Text(authService.usuario.nombre.substring(0,2).toUpperCase()),),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: () {
                    _prefs.token = '';
                    socketService.disconnect();
                    Navigator.pushReplacementNamed(context, 'login');
                }, child: CircleAvatar(backgroundColor: Colors.red,child: FaIcon(FontAwesomeIcons.signOutAlt, color: Colors.white,))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}