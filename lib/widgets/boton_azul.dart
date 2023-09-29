import 'package:flutter/material.dart';


class BotonAzul extends StatelessWidget {

  final String text;
  final VoidCallback  onPressed;

  const BotonAzul({
    super.key,
    required this.text,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(2),
        shape: MaterialStatePropertyAll( RoundedRectangleBorder( 
          borderRadius: BorderRadius.circular(30) ) )
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text, style: const TextStyle( fontSize: 18),),
        ),
      )
    );
  }
}