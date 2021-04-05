import 'package:flutter/material.dart'; // importacion del material disponible de dart

//rutas
import 'package:chatapp/routes/routes.dart';
import 'package:provider/provider.dart';

import 'package:chatapp/services/auth_service.dart';
import 'package:chatapp/services/socket_service.dart';
import 'package:chatapp/services/chat_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ( _ )=> AuthService()), // se crea una instancia global del servicio de autenticacion que pasa atravez de context
            ChangeNotifierProvider(create: ( _ )=> SocketService()), // se crea una instancia global del servicio de sockets que pasa atravez de context
            ChangeNotifierProvider(create: ( _ )=> ChatService()), // se crea una instancia global del servicio de chat que pasa atravez del context
          ],
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'chat App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}

