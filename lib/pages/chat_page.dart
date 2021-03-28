import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:chatapp/widgets/message_chat.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  
  final  _textController = TextEditingController();
  final _focusNode =FocusNode();
  bool _estadoEscribir = false;
  List<MessageChat> _mensajes  =[ ];  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            child: Text("Mc",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold )),
            maxRadius: 5,
            backgroundColor: Colors.blue[100],
          ),
        ),
        title: Column(
          children: <Widget>[
            Text("Manuel castro", style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.bold)),
            Text("conectado(a) ahora", style: TextStyle(color: Colors.black54,fontSize: 12)),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),

      body: Container(
        child: Column(
          children:<Widget>[
            
            Flexible(
              child:ListView.builder(
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemCount: _mensajes.length,
                itemBuilder: (_,i)=> _mensajes[i],
              )
            ),
            Divider(height: 1),
            //CAJA DE TEXTO
            Container(
              color: Colors.white,
              child: inputChat(),
            )
          ],
        ),
      ),
    );
  }




Widget inputChat(){
  return SafeArea(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children:<Widget> [
          Flexible(
            child: TextField(
              controller:_textController,
              onSubmitted:_handleSubmit,
              onChanged: (String texto){
                setState(() {
                      
                  if(texto.trim().length > 0 ){
                    _estadoEscribir= true;
                  } else {
                    _estadoEscribir =false;
                  }
                  
                });
              },
              decoration: InputDecoration.collapsed(
                hintText: 'enviar mensaje'
              ),
              focusNode: _focusNode,
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0), 
            child: Platform.isIOS ? 
              CupertinoButton(
                child: Text("enviar"),
                onPressed:_estadoEscribir
                  ? ()=>_handleSubmit(_textController.text.trim()) 
                  : null,
              )  
              
          :Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue[400]),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.send),
                  onPressed: _estadoEscribir
                  ? ()=>_handleSubmit(_textController.text.trim()) 
                  : null,
                ),
              ), 
          )
          ),
        ],
      ),
    )
  );
}

  _handleSubmit(String text){

    if(text.length==0) return;

    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = new MessageChat(
      texto: text,
      uid: '123',
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 350)),
    );

    _mensajes.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estadoEscribir = false;
    });
  }

  //vamos a limpiar el controlador de la animacion cada vez que salgamos de la pantalla para con consumir espacio
  //inecesario en la memoria
  @override
  void dispose(){
    for(MessageChat messageChat in _mensajes){
      messageChat.animationController.dispose();
    }
    super.dispose();
  }


  
}


