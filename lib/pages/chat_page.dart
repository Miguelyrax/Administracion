import 'package:administracion/model/usuario_model.dart';
import 'package:administracion/services/chat_service.dart';
import 'package:administracion/services/usuarios_service.dart';
import 'package:administracion/widgets/headers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Usuario> usuarios = [];
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
 
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final usuariosService = Provider.of<UsuarioService>(context);
     this.usuarios = usuariosService.usuarios;
    return Scaffold(
      body: Stack(
        children: [
          Container(
                 margin: EdgeInsets.only(top: 300),
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              header: WaterDropHeader(
              complete: Icon(Icons.check, color: Color(0xffFDA7DF),),
              waterDropColor: Color(0xffFDA7DF),
              ),
              onRefresh: _cargarUsuarios,
              child: _refresh(context)),
          ),
       
          Header(icono: FontAwesomeIcons.facebookMessenger, titulo: 'Chat', color1: Color(0xffD980FA), color2: Color(0xffFDA7DF),),
        ],
      ),
   );
  }

  Widget _refresh(BuildContext context) {
    return Container(
       
          child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              physics: BouncingScrollPhysics(),
              itemCount: usuarios.length,
              itemBuilder: (_,i)=> ListTile(
                title: Text(usuarios[i].nombre),
                leading: CircleAvatar(child: Text(usuarios[i].nombre.substring(0,2).toUpperCase()), backgroundColor: Colors.blueAccent,),
                trailing: usuarios[i].online == 'true' ? Icon(Icons.circle, color: Colors.green, size: 10,) :Icon(Icons.circle, color: Colors.red, size: 10,) ,
                onTap: (){
                  final chatService = Provider.of<ChatService>(context,listen: false);
                  chatService.usuario = usuarios[i];
                  Navigator.pushNamed(context, 'mensajes');
                },
            ))
            
          );
  }

 

  void _cargarUsuarios() async{
    final usuariosService = Provider.of<UsuarioService>(context, listen: false);
    this.usuarios = await usuariosService.getUsuarios();
    setState(() {
      
    });
    _refreshController.refreshCompleted();
  }
}