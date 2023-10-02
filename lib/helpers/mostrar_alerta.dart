import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo ) {
  
if ( Platform.isAndroid) {
  return showDialog(
    context: context,
    builder: ( _ ) => AlertDialog(
      title: Text( titulo ),
      content: Text( subtitulo ),
      actions: [
        MaterialButton(
          elevation: 5,
          textColor: Colors.blueAccent,
          
          onPressed: () =>  Navigator.pop(context),
          child: const Text('Ok'),
        ),
        
      ],
    )
  );

}

showCupertinoDialog(
  context: context, 
  builder: ( _ ) => CupertinoAlertDialog(
    title: Text( titulo ),
    content: Text( subtitulo ),
    actions: [
      CupertinoDialogAction(
        isDefaultAction: true,
        child: const Text('Ok'),
        onPressed: () => Navigator.pop(context),
      )
    ],

  )
);



}