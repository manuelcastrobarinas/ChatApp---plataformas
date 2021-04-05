import 'package:flutter/material.dart';

import 'login_page.dart';
import 'usuarios_page.dart';

import 'package:provider/provider.dart';

import '../services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';

class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context,snapshot){
        return Center(
            child: Text('espere'),
          );
        },
      ),
    );
  }


  Future checkLoginState(BuildContext context) async{

    final authservice = Provider.of<AuthService>(context,listen: false);
    final socketService = Provider.of<SocketService>(context);

    final autenticado = await authservice.estalogeado();
    
    if (autenticado){
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: ( _,__,___ ) =>UsuariosPage(),
          transitionDuration: Duration(microseconds:0)
        )
      );
    }else{
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: ( _,__,___ ) =>LoginPage(),
          transitionDuration: Duration(microseconds:0)
        )
      );
    }
  }

}
