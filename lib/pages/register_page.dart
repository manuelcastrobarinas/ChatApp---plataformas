import 'package:chatapp/widgets/InputsPersonalizados.dart';
import 'package:chatapp/widgets/boton_azul.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/material.dart';


import 'package:provider/provider.dart';
import '../helpers/mostrar_alerta.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF2F2F2),     
    
      body: SafeArea( //nos pone en un area que distingue si existe notch
        child: SingleChildScrollView( //hace que podamos hacer escrol y ayuda a solucionar error de despliegue de pantalla 
        physics: BouncingScrollPhysics(), // hace que rebote el scrollview
          child: Container( //este contenedor va a tener todas las columnas principales
            height: MediaQuery.of(context).size.height * 1.0,  // hace que los elementos ocupen el 100% del espacio de la pantalla esto arregla el error de super posicion del boton
            child: Column(  //creacion de columnas principales
            mainAxisAlignment:  MainAxisAlignment.spaceBetween, //espacio equivalente
              children:  [
                Logo(title: 'registro',rutaLogo: 'assets/perfil.png',),
                _Form(),
                Labels(ruta: 'login',textOne: '¿ya tienes cuenta?',textTwo: 'ingresa con tu cuenta ahora',),
                Text('terminos y condiciones de uso',  style: TextStyle(fontWeight: FontWeight.w200))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
 
  final nameControler = TextEditingController();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authservice = Provider.of<AuthService>(context); 

    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            
            InputsPersonalizados(
              icon: Icons.perm_identity,
              placeholder: 'nombre',
              keyboardType: TextInputType.text,
              textcontroller: nameControler,
            ),

            InputsPersonalizados(
              icon: Icons.email_outlined,
              placeholder: 'correo',
              keyboardType: TextInputType.emailAddress,
              textcontroller: emailControler,
            ),
            InputsPersonalizados(
              icon: Icons.lock,
              placeholder: 'contraseña',
              textcontroller: passwordControler,
              isPassword: true,
            ),
            
           BotonAzul(
             textoBoton: 'registrar',
              onpressed: authservice.autenticando ? null: ()async{
                print(nameControler.text);
                print(emailControler.text);
                print(passwordControler.text);

                final registroOK= await authservice.register(nameControler.text.trim(), emailControler.text.trim(), passwordControler.text.trim());
                if(registroOK ==true ){
                  //TODO: conectar al socket server
                  Navigator.pushReplacementNamed(context, 'login');
                }else{
                  mostrarAlerta(context,'registro incorrecto', registroOK);
                }
              }
            ),
          ],
        )
    );
  }
}