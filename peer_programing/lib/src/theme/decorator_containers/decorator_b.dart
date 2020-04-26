import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/circular_container.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';

class DecorationContainerB extends Stack{
  DecorationContainerB(Color primary, double top, double left):super(
    children: <Widget>[
        Positioned(
          top: -65,
          right: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Colors.blue.shade100,
            child: CircleAvatar(radius: 30, backgroundColor: primary),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.lightseeBlue, radius: 40)))
      ],
  );
}