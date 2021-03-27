import 'package:chatapp/widgets/InputsPersonalizados.dart';
import 'package:chatapp/widgets/boton_azul.dart';
import 'package:chatapp/widgets/labels.dart';
import 'package:chatapp/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),     
    
      body: SafeArea( //nos pone en un area que distingue si existe notch
        child: SingleChildScrollView( //hace que podamos hacer escrol y ayuda a solucionar error de despliegue de pantalla 
        physics: BouncingScrollPhysics(), // hace que rebote el scrollview
          child: Container( //este contenedor va a tener todas las columnas principales
            height: MediaQuery.of(context).size.height * 0.9,  // hace que los elementos ocupen el 90% del espacio de la pantalla
            child: Column(  //creacion de columnas principales
            mainAxisAlignment:  MainAxisAlignment.spaceBetween, //espacio equivalente
              children:  [
                Logo(title: 'registro',),
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
             textoBoton: 'ingresar',
              onpressed: (){
                print(emailControler.text);
                print(passwordControler.text);
              }
            ),
          ],
        )
    );
  }
}