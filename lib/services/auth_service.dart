
import 'dart:convert';

import 'package:chatapp/global/environment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // este paquete es importante importarlo para usar la libreria que almacenara nuestro token en un lugar seguro

import 'package:chatapp/models/login-response.dart';

import '../models/usuario.dart';

class AuthService with ChangeNotifier{
  

  Usuario usuario;
  bool _autenticando = false;
  final _storage = new FlutterSecureStorage(); // instancia de la libreria que nos ayuda en el almacenamiento del token

  bool get autenticando => this._autenticando;
  set autenticando (bool valor){
    
    this._autenticando = valor;
    notifyListeners();
  }

  //getters y setters de forma estatica para poder usar el token en otro lugar haciendo referencia al authservice sin comprometer el token
  static Future<String> getToken() async{
    final _storage = new FlutterSecureStorage();
    final token= await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{

    final _storage= new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }


  

  Future <bool> login(String email, String password) async{

    this.autenticando = true;
    // esta data es lo que recibimos del backend, asi que se tiene que llamar exactamente igual que los parametros que hay alla
    final data ={
      'email':email,
      'password':password
    };
    
    final uri = Uri.parse('${Environment.apiUrl}/login');
    final resp = await http.post(uri,
      
      body: jsonEncode(data),
      headers: {
        'content-Type':'application/json'
      }
    );

    print(resp.body);
    this.autenticando = false;

    if(resp.statusCode == 200 ){  
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario; //
      
      await this._guardarToken(loginResponse.token); // aqui guardamos el token

      return true;
    } else{
      return false;
    }
  }


  Future register(String nombre, String email, String password) async{

    this.autenticando = true;

    final data ={
      'nombre':nombre,
      'email': email,
      'password':password
    };

     final uri = Uri.parse('${Environment.apiUrl}/login/new');
     final resp = await http.post(uri,
      body: jsonEncode(data),
      headers:{ 'content-type':'application/json'} 
     );

    print(resp.body);
    this.autenticando = false;

    if(resp.statusCode == 200 ){  
      
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario; //

      await this._guardarToken(loginResponse.token); // aqui guardamos el token

      return true;
    } else{

      final  respuestaCuerpo = jsonDecode(resp.body);
      return respuestaCuerpo['mensaje'];
    }
  }


  Future<bool> estalogeado() async{
    final token = await this._storage.read(key:'token');
    print("este es el token");
    print(token);

    


    final uri = Uri.parse('${Environment.apiUrl}/login/renew');
    final resp = await http.get(uri,
      
      headers: {
        'content-Type':'application/json',
        'x-token': token
      }
    );

    print(resp.body);

    if(resp.statusCode == 200 ){  
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario; //
      
      await this._guardarToken(loginResponse.token); // aqui guardamos el token
      return true;
    } else{
      this.logout();
      return false;
    }


  }

  Future _guardarToken(String token) async{
   return await _storage.write(key: 'token', value: token); //ecribimos el token en nuestro storage, recibimos el token de backend por la llave
  }

  Future logout()async{
    await _storage.delete(key: 'token'); // buscamos el token y lo eliminamos para deslogearnos
  }

}