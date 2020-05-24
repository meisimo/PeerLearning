import 'package:flutter/material.dart';

class CircularLoading extends StatelessWidget{
  @override
  Widget build(BuildContext context) => Container(
    constraints: BoxConstraints(
      maxHeight: 100,
      maxWidth: 100,
      minHeight: 50,
      minWidth: 50,
    ),
    child: CircularProgressIndicator(),
  );
}