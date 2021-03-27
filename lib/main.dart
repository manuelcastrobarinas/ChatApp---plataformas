import 'package:flutter/material.dart'; // importacion del material disponible de dart

//rutas
import 'package:chatapp/routes/routes.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'chat App',
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}

