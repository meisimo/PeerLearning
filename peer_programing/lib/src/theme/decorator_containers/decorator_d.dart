import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/circular_container.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';

class DecorationContainerD extends Stack{
  DecorationContainerD(Color primary, double top, double left,
      {Color secondary, Color secondaryAccent}):super(
    children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: secondary,
          ),
        ),
        SmallContiner(LightColor.yellow, 18, 35, radius: 12),
        Positioned(
          top: 130,
          left: -50,
          child: CircleAvatar(
            radius: 80,
            backgroundColor: primary,
            child: CircleAvatar(radius: 50, backgroundColor: secondaryAccent),
          ),
        ),
        Positioned(
          top: -30,
          right: -40,
          child: CircularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
  );
}