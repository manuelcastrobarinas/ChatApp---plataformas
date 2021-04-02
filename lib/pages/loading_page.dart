import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_page.dart';
import 'usuarios_page.dart';

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
    final autenticado = await authservice.estalogeado();

    if (autenticado){
      //TODO: conectar al socket server
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
