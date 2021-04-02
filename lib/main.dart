import 'package:chatapp/services/auth_service.dart';
import 'package:flutter/material.dart'; // importacion del material disponible de dart

//rutas
import 'package:chatapp/routes/routes.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: ( _ )=> AuthService(),) // se crea una instancia global del servicio de autenticacion
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

