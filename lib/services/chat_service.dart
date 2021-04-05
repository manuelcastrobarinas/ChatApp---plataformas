import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/models/mensajes_response.dart';

import 'package:chatapp/global/environment.dart';

import 'auth_service.dart';


class ChatService with ChangeNotifier{
  Usuario usuarioPara;


  Future<List<Mensaje>>getChat(String usuarioID) async{

  final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
  final resp = await http.get(uri,
   headers:{
      'content-Type':'application/json',
      'x-token'     : await AuthService.getToken()
    });

  final mensajesResp = mensajesResponseFromJson(resp.body);
  return mensajesResp.mensajes;

  }
}

