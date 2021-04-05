
import 'package:http/http.dart' as http;

import 'package:chatapp/models/usuario.dart';
import 'package:chatapp/global/environment.dart';
import 'auth_service.dart';

import 'package:chatapp/models/usuarios_response.dart';

class UsuariosService {

  Future<List<Usuario>> getUsuarios() async{

    try {
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final resp = await http.get(uri, 
        headers:{
          'content-type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

    final usuariosResponse = usuariosResponseFromJson(resp.body);
    return usuariosResponse.usuarios;
    
    } catch (e) {
      return[];
    }
  }
}