import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String textOne;
  final String textTwo;
  final String ruta;

  const Labels({
    Key key,
    @required this.textOne,
    @required this.textTwo,
    @required this.ruta
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(this.textOne, style: TextStyle( color: Colors.black54, fontSize: 15,fontWeight: FontWeight.w300)),
          SizedBox(height: 10),
          GestureDetector( // me permite poner cualquier gesto y reconocerlo
            child: Text(this.textTwo, style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: (){
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          ),
        ],
      ),
    );
  }
}