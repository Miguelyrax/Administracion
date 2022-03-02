import 'package:administracion/services/authservice.dart';
import 'package:administracion/services/chat_service.dart';
import 'package:administracion/services/mensajes_response.dart';
import 'package:administracion/services/socket_service.dart';
import 'package:administracion/widgets/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';


class MensajesPage extends StatefulWidget {

  @override
  _MensajesPageState createState() => _MensajesPageState();
}

class _MensajesPageState extends State<MensajesPage> with TickerProviderStateMixin {
    
   final textCtrl = TextEditingController();
  List<ChatMessage> _messages = [ ];
  SocketService socketService;
  ChatService chatService;
  AuthService authService;
  @override
  void initState() {
    this.socketService = Provider.of<SocketService>(context, listen: false);
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);

    this.socketService.socket.on('mensaje-personal', _recibirMensaje);

    _cargarMensajes(chatService.usuario.id);

    super.initState();
  }

  void _cargarMensajes(String id)async{
    List<Mensaje> mensajes = await chatService.getUsuarios(id);
    
    final history = mensajes.map((m) => 
     
      ChatMessage(message: m.mensaje, uid: m.de,)
    );

    setState(() {
    _messages.insertAll(0, history);
      
    });
  }

  void _recibirMensaje(payload){
    final newMessage = ChatMessage(message: payload.mensaje, uid: payload.uid);
    _messages.insert(0, newMessage);
  }

  @override
  Widget build(BuildContext context) {
    final chatService = Provider.of<ChatService>(context);
    return Scaffold(
      appBar: AppBar(
        title:Text(chatService.usuario.nombre, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Flexible(child: ListView.builder(
            reverse: true,
            itemCount: _messages.length,
            itemBuilder: ( _ ,  i) => _messages[i],)),
          SafeArea(
            child: Container(
              width: double.infinity,
              height: 50,
              child: inputChat(),
            ),
          )
        ],
      ),
   );
  }

  Widget inputChat() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xffD7D7D7),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    onSubmitted: _handleSubmit,
                    controller: textCtrl,
                    decoration: InputDecoration(
                      hintText: 'Mensaje...',
                      border: InputBorder.none,
                      ),
                  ),
                ),
              )),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(100)
              ),
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white, size: 20,),
                onPressed: ()=>_handleSubmit(textCtrl.text),
              ),
            )
          ],
        ),
        
      ),
    );
  }
  void _handleSubmit(String value) {
    
    socketService.emit('mensaje-personal',{
      "de": authService.usuario.id,
      "para": chatService.usuario.id,
      "mensaje":value
    });
    final newMessage = ChatMessage(message: value, uid: authService.usuario.id,);
    _messages.insert(0, newMessage);
    setState(() {
      
    });
  }
}

