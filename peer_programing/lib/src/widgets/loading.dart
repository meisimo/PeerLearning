import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class Loading extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxHeight: 100,
      maxWidth: 100,
      minHeight: 50,
      minWidth: 50,
    ),
    child: JumpingText(
      'Cargando...',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold
      ),
    ),
  );
}