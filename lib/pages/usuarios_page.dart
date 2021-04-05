import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart'; // importamos la libreria pull to refresh

import 'package:chatapp/models/usuario.dart';

import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'package:chatapp/services/chat_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/usuarios_services.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}


class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController =RefreshController(initialRefresh: false); // controlador del pull to refresh

  final usuariosService = new UsuariosService();
  List<Usuario> usuarios =[];  


  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }
    
  @override
  Widget build(BuildContext context) {

    final authservice = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario =authservice.usuario;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){
      
            socketService.disconnect();
            Navigator.pushReplacementNamed(context, 'login'); //sacamos al usuario de la pantalla y lo redirigimos al login
            AuthService.deleteToken(); // y aqui eliminamos el token para que no lo mantenga en la sesion
            
            
          },
        ),
        title: Center(
          child: Text(usuario.nombre,style: TextStyle(color: Colors.black87),)
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus == ServerStatus.Online) 
            ? Icon(Icons.check_circle,  color: Colors.blue[400])
            : Icon(Icons.offline_bolt,  color: Colors.red[400]),
          )
        ],
      ),
      body: SmartRefresher( // uso de la libreria, pull to refresh
        controller: _refreshController,
        enablePullDown: true, //hacemos que genere el pull cuando bajemos la pantalla
        onRefresh: _cargarUsuarios,
        header:WaterDropHeader( // genera un pull to refresh en forma de gota
          complete: Icon(Icons.check,color: Colors.blue[400]), //darle el icono de check y cargarlo en azul
          waterDropColor: Colors.blue[200], //darle color a la gota de refresco
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
     physics: BouncingScrollPhysics(),
     itemBuilder:(_, i)=>_usuarioListTile(usuarios[i]),
     separatorBuilder: (_, i) => Divider(),
     itemCount: usuarios.length
    );
  }


  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
       leading: CircleAvatar(
         child: Text(usuario.nombre.substring(0,2)),
         backgroundColor: Colors.blue[100],
       ),
       title: Text(usuario.nombre),
       subtitle: Text(usuario.email),
       trailing: Container(
         width: 10,
         height: 10,
         decoration: BoxDecoration(
           color: usuario.online ? Colors.green[300] : Colors.red,
           borderRadius: BorderRadius.circular(100)
         ),
       ),
       onTap: (){
         final chatService =Provider.of<ChatService>(context, listen:false);
         chatService.usuarioPara = usuario;
         Navigator.pushNamed(context, 'chat');
       },
     );
  }

 _cargarUsuarios() async{
   
   this.usuarios= await usuariosService.getUsuarios();
   setState(() {
     
   });
    //await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
