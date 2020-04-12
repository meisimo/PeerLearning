import 'package:flutter/material.dart';

class SmallContiner extends Positioned {
  SmallContiner(Color primary, double top, double left, {double radius = 10})
      : super(
            top: top,
            left: left,
            child: CircleAvatar(
              radius: radius,
              backgroundColor: primary.withAlpha(255),
            ));
}
