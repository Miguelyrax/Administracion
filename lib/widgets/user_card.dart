import 'package:administracion/model/usuario_model.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
final usuarios = UsuarioService();
class UserCard extends StatefulWidget {
  final Usuario user;
  const UserCard({
    Key key, this.user,
  }) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
      child: ListTile(
      title: Text('${widget.user.nombre}'),
         
      // leading: CircleAvatar(child: FaIcon(FontAwesomeIcons.user),),
      trailing: DropdownButton<String>(
      value: widget.user.role,
      icon: const FaIcon(FontAwesomeIcons.arrowDown, size: 15, color: Color(0xffA3CB38),),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 2,
        color: Color(0xffA3CB38),
      ),
      onChanged: (String newValue) async{
          final resp = await usuarios.editRole(newValue, widget.user.id);
          if(resp){
            widget.user.role = newValue;
          }else{
            showDialog(context: context, builder: (context) {
              return AlertDialog(
              content: SingleChildScrollView(
               
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.exclamationCircle, size: 50, color: Colors.red,),
                    SizedBox(height: 30,),
                    Text('Error', style: TextStyle(fontWeight: FontWeight.bold),),
                    Text('No tiene los permisos',),
                    SizedBox(height: 30,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red
                      ),
                      onPressed: ()=>Navigator.pop(context),
                      child: Text('OK')),
                      
                  ],
                ),
              ),
            );
            });
            
          }
        setState(() {
        });
      },
      items: <String>['ADMIN-ROLE', 'USER-ROLE', 'TEACHER-ROLE']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
          onTap: (){},
        ),
      ),
    );
  }
}