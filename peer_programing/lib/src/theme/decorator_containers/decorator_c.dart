import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/circular_container.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';

class DecorationContainerC extends Stack{
  DecorationContainerC(Color primary, double top, double left):super(
    children: <Widget>[
        Positioned(
          top: -105,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.orange.withAlpha(100),
          ),
        ),
        Positioned(
            top: 35,
            right: -40,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.orange, radius: 40))),
        SmallContiner(
          LightColor.yellow,
          35,
          70,
        )
      ],
  );
}