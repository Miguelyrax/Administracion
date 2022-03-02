import 'package:administracion/preferences/preferencias_usuario.dart';
import 'package:administracion/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class OptionPage extends StatefulWidget {

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  
  final prefs = PreferenciasUsuario();
  bool color = false;
  Color pintarFondo;
  Color pintarText;
  @override
    void initState() {
      this.color = prefs.colorSecundario;
      this.color? this.pintarFondo = Colors.black : this.pintarFondo = Colors.white;
      this.color? this.pintarText = Colors.white : this.pintarText = Colors.black;

      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pintarFondo,
      body: Stack(
        children: [
         
          Container(
            margin: EdgeInsets.only(top: 320),
            child: Column(children: [
              Text('Configuraciones', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color:  pintarText),),
              Divider(color: pintarText.withOpacity(0.2),),
              Text('Color secundario', style: TextStyle(color:  pintarText),),
              Switch(
                value: color ,
                
                onChanged: (value){
                  prefs.colorSecundario = value;
                  color = value;
                  value ? pintarFondo = Colors.black : this.pintarFondo = Colors.white;
                  value ? pintarText = Colors.white : this.pintarText = Colors.black;
                  setState(() {
                                      
                                    });
                })
            ],),
          ),
          Header(colorSombra: this.pintarText,
          color1:Color(0xff833471) , titulo: 'Configuración', color2:Color(0xffB53471) , icono: FontAwesomeIcons.cog,
        ),
          Column(

          ),
        ],
      ),
   );
  }
}