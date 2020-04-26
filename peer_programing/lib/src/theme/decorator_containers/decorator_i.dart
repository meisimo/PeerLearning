import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';

class DecorationContainerI extends Stack {
  DecorationContainerI() : super(
    children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        SmallContiner(
          Colors.yellow,
          35,
          70,
        ),
      ],
  );
}