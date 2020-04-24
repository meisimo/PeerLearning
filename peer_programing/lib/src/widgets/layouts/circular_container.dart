import 'package:flutter/material.dart';

class CircularContainer extends Container {
  CircularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2})
      : super(
            height: height,
            width: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
              border: Border.all(color: borderColor, width: borderWidth),
            ));
}
