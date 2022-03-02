import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class BTN extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final String titulo;
  final IconData icon;
  final Color colorbtn;
  const BTN({
     this.icon = FontAwesomeIcons.circle, this.color1 = Colors.grey, this.color2 = Colors.blueGrey, this.color3 = Colors.white, this.titulo = '', this.colorbtn = Colors.white,
  });

  @override
  _BTNState createState() => _BTNState();
}

class _BTNState extends State<BTN> {
  final prefs = PreferenciasUsuario();
  bool color = false;
  Color pintarFondo;
  Color pintarText;
  @override
    void initState() {
      this.color = prefs.colorSecundario;
      this.color? this.pintarFondo = Colors.white : this.pintarFondo = Colors.black;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Stack(
         children: [
           Hero(tag: this.widget.titulo,child: boton(colorSombra: pintarFondo,color1: this.widget.color1, color2: this.widget.color2, icon: this.widget.icon,)),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               SizedBox(height: 120, width: 40,),
                FaIcon(this.widget.icon, color: this.widget.colorbtn, size: 50,),
                SizedBox(width: 20,),
                Expanded(child: Text(this.widget.titulo, style: TextStyle(color: this.widget.color3),)),
                FaIcon(FontAwesomeIcons.chevronRight, color: this.widget.colorbtn, size: 20,),
                SizedBox(width: 40,)
             ],
           )
         ],
       );
  }
}

class boton extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;
  final Color colorSombra;
  const boton({
    this.color1, this.color2 , this.icon, this.colorSombra ,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(20),
      height: 80,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            this.color1,
            this.color2
          ]
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: this.colorSombra.withOpacity(0.4),
            blurRadius: 9,
            spreadRadius: 0.2,
            offset: Offset(1,4)
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [

            Positioned( top: -30,right: -20,child:FaIcon(this.icon, color: Colors.white24, size: 150,)),
           
          ],
        ),
      ),
    );
  }
}