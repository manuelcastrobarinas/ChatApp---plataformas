import 'package:flutter/material.dart';
class Logo extends StatelessWidget {
  
  final String title;
  final String rutaLogo;

  const Logo({
    Key key,
    @required this.title,
    @required this.rutaLogo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage(this.rutaLogo)),
            SizedBox(height: 20), // un hr en html
            Text(this.title, style: TextStyle(fontSize: 30)),
          ],
        ),
      ),
    );
  }
}