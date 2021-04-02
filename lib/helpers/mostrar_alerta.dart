

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
mostrarAlerta(BuildContext context, String titulo, String subtitulo){

  if(Platform.isAndroid ){
    return  showDialog(
    context: context,
     builder: ( _ ) =>AlertDialog( 
       title: Text(titulo),
       content: Text(subtitulo),
       actions: [
         MaterialButton(
          child: Text('ok'),
          elevation: 5,
          textColor: Colors.blue,
          onPressed: ()=> Navigator.pop(context)
         )
       ],
     )
    );
  }else{
    showCupertinoDialog(
    context: context,
     builder:(_) => CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('ok'),
          onPressed: ()=>Navigator.pop(context),
        )
      ],
     )
    );
  }
}