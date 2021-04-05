import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:chatapp/widgets/message_chat.dart';

import 'package:provider/provider.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';

import 'package:chatapp/models/mensajes_response.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  
  
  final  _textController = TextEditingController();
  final _focusNode =FocusNode();
  bool _estadoEscribir = false;

    

  ChatService chatService;
  SocketService socketService;
  AuthService authService;

  List<MessageChat> _mensajes  =[];
  
  @override
  void initState() { 
    super.initState();
    this.chatService   = Provider.of<ChatService>(context, listen:false);
    this.socketService = Provider.of<SocketService>(context,listen:false);
    this.authService   = Provider.of<AuthService>(context,listen:false);

    this.socketService.socket.on('mensaje-personal', _escucharMensaje);

    _cargarHistorial(this.chatService.usuarioPara.uid);
  }

  void _cargarHistorial(String usuarioID) async{
    
    List<Mensaje> chat = await this.chatService.getChat(usuarioID);
    
    final history = chat.map((m) => new MessageChat(
      texto: m.mensaje,
      uid: m.emisor,
      animationController: new AnimationController(vsync: this, duration: Duration(milliseconds:300))..forward(),
    ));

    setState(() {
      _mensajes.insertAll(0,history);
    });
  }

  void _escucharMensaje(dynamic payload){
    MessageChat mensaje = new MessageChat(
      texto: payload['mensaje'],
      uid:   payload['emisor'],
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 300)),
    );
    setState(() {
      _mensajes.insert(0, mensaje);
    });

    mensaje.animationController.forward();
  }
  
  @override
  Widget build(BuildContext context) {


    final usuarioPara = chatService.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Container(
          padding: EdgeInsets.all(5),
          child: CircleAvatar(
            child: Text(usuarioPara.nombre.substring(0,2),style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold )),
            maxRadius: 5,
            backgroundColor: Colors.blue[100],
          ),
        ),
        title: Column(
          children: <Widget>[
            Text(usuarioPara.nombre, style: TextStyle(color: Colors.black87,fontSize: 14,fontWeight: FontWeight.bold)),
            (usuarioPara.online ==true)? Text("conectado(a) ahora" ,style: TextStyle(color: Colors.green[300],fontSize: 12,fontWeight: FontWeight.bold))
                                       : Text("desconectado(a)" ,style: TextStyle(color: Colors.black54,fontSize: 12)),
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
      uid: authService.usuario.uid, //mi uid
      animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 350)),
    );

    _mensajes.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() { _estadoEscribir = false; });

    this.socketService.emit('mensaje-personal',{
      'emisor'  : this.authService.usuario.uid,
      'receptor': this.chatService.usuarioPara.uid,
      'mensaje' : text
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


