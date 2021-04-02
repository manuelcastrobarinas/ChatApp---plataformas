import 'dart:io';

class Environment {
//comunicacion al backend para los servicios rest
  static String apiUrl   =Platform.isAndroid ? 'http://192.168.56.1:3000/api': 'http://locahost:3000/api';
//comunicacion al servidor de sockets
  static String socketUrl=Platform.isAndroid ? 'http://192.168.56.1:3000'    : 'http://locahost:3000';
}

/*
NOTA IMPORTANTE!!!
ANDROID NO TRABAJO CON LOCALHOST, ASI QUE LA DIRECCION IP QUE TENEMOS POR DEFECTO ES LA DE NUESTRO EQUIPO
ES IMPORTANTE MANTENERLO BAJO EL SERVICIO HTTP Y NO HTTPS PORQUE GENERA UN ERROR EN LOS CORS, SIN EMBARGO ESTO 
VA A DAR UN PROBLEMA, PORQUE FLUTTER, O BUENO ANDROID A PARTIR DE LA VERSION 9....  QUITO LAS CONEXIONES INSEGURAS
COMO PUEDE SER EL SERVICIO PUERTO HTTP, LO CUAL VA A HACER QUE NOS SE LLEVE A CABO LA PETICION AL BACKEND, PARA ARREGLAR ESO
DEBEMOS MIGRAR ANDROID EN NUESTRO PROYECTO DE FLUTTER ASI:

vamos a la ruta android/app/src/main/androidManifest.xml en este archivo tenemos que poner 


android:usesCleartextTraffic="true" debajo de <application y tambien

<uses-permission android:name="android.permission.INTERNET" /> encima de <application 

asi le damos a entender a android que nos habilite la conexion por el puerto http
*/