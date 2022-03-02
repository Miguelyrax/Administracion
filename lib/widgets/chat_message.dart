import 'package:administracion/services/authservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ChatMessage extends StatelessWidget {
  final String message;
  final String uid;

  const ChatMessage({Key key, @required this.message, @required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final authService = Provider.of<AuthService>(context);
    return Container
    (child: this.uid == authService.usuario.id ? _MyMessage(message: message) : _NoMyMessage(message: message,));
  }
}

class _NoMyMessage extends StatelessWidget {
  final String message;
  const _NoMyMessage({
    Key key, this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 100, bottom: 20, left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(this.message, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}

class _MyMessage extends StatelessWidget {
  const _MyMessage({
    Key key,
    @required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, bottom: 20, left: 100),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text(this.message, style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}