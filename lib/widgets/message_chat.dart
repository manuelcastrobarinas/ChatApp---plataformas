import 'package:flutter/material.dart';

class MessageChat extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const MessageChat({
    Key key,
    @required this.texto,
    @required this.uid,
    @required this.animationController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:CurvedAnimation(parent: animationController, curve: Curves.easeOut ) ,
        child: Container(
          child: this.uid == '123'
          ? _myMessage()
          : _youMessage(),
        ),
      ),
    );
  }

  Widget _myMessage(){
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5,left: 100,right: 5),
        child: Text(this.texto, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
  Widget _youMessage(){
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5,right: 100,left: 5),
        child: Text(this.texto, style: TextStyle(color: Colors.black87)),
        decoration: BoxDecoration(
          color: Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(18),
        ),
      ),
    );
  }
}