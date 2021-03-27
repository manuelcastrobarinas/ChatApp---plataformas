import 'package:flutter/material.dart';

class InputsPersonalizados extends StatelessWidget {
  
  final IconData icon;
  final String placeholder;
  final TextEditingController textcontroller;
  final TextInputType keyboardType;
  final bool isPassword;

  const InputsPersonalizados({
    
    Key key,
    @required this.icon,
    @required this.placeholder,
    @required this.textcontroller,
    this.keyboardType = TextInputType.text,
    this.isPassword =false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(  // es como un div de html
      padding: EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20), // padding de los imputs el right esta mas pronunciado
      margin: EdgeInsets.only(bottom: 20), // para dar espacio inferior al elemento que le siga
      decoration: BoxDecoration(   // sirve para hacer decoracion, en este caso del div
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: Offset(0, 5),
              blurRadius: 5,
            ),
          ]),
      child: TextField( //le estamos diciendo que su hijo sea de tipo input
      controller: this.textcontroller,
        autocorrect: false,
        keyboardType: this.keyboardType,
        obscureText: isPassword,
        decoration: InputDecoration(
            prefixIcon: Icon(this.icon), //fija el icono al input
            border: InputBorder.none, // quita la linea baja de los inputs
            focusedBorder:InputBorder.none, // quita la linea baja de los inputs una ves que nos hacemos encima
            hintText: this.placeholder
        ),
      ),
    );
  }
}
  