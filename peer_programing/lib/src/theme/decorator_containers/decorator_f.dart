import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';

class DecorationContainerF extends Stack{
  DecorationContainerF(Color primary, Color secondary, double top, double left):super(
    children: <Widget>[
        Positioned(
            top: 25,
            right: -20,
            child: RotatedBox(
              quarterTurns: 1,
              child: ClipRect(
                  clipper: QuadClipper(),
                  child: CircleAvatar(
                      backgroundColor: primary.withAlpha(100), radius: 50)),
            )),
        Positioned(
            top: 34,
            right: -8,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: secondary.withAlpha(100), radius: 40))),
        SmallContiner(LightColor.yellow, 15, 90, radius: 5)
      ],
  );
}