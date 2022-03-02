import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class Input extends StatelessWidget {
  final String texto;
  final IconData icono;
  final bool hint;
  final int line;
  final TextEditingController txtController;
  const Input({
    Key key, this.texto, this.icono, this.hint = false, this.txtController, this.line = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffEDEFF0),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 1,
          spreadRadius: 1
        )]
      ),
      child: TextField(
        obscureText: this.hint,
        maxLines: this.line,
        decoration: InputDecoration(
          hintText: this.texto,
         border: InputBorder.none,
          icon: FaIcon(this.icono)
        ),
        controller: txtController,
      ),
    );
  }
}