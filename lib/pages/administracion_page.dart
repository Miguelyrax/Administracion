import 'package:administracion/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class AdminPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Header(
          color1:Color(0xffEE5A24) , titulo: 'Administracion', color2:Color(0xffF79F1F) , icono: FontAwesomeIcons.unlock,
        ),
   );
  }
}