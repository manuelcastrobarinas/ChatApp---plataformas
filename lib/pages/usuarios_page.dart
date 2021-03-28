import 'package:chatapp/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart'; // importamos la libreria pull to refresh

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}


class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController =RefreshController(initialRefresh: false); // controlador del pull to refresh

  final usuarios =[
    Usuario(uid:'1', nombre:'esteban sanabria' ,email:'esteban@gmail.com'  ,online:true ),
    Usuario(uid:'2', nombre:'miguel botia' ,email:'miguel@gmail.com'  ,online:false ),
    Usuario(uid:'3', nombre:'manuel castro' ,email:'manuel@gmail.com'  ,online:true )
  ];  
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon:Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: (){},
        ),
        title: Center(
          child: Text('mi nombre',style: TextStyle(color: Colors.black87),)
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle,  color: Colors.blue[400],),
            //child: Icon(Icons.offline_bolt,  color: Colors.red[400],),
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
     );
  }

 _cargarUsuarios() async{
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
