import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/circular_container.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';


class DecorationContainerG extends Stack {
  DecorationContainerG() : super(
    children: <Widget>[
        Positioned(
          top: -110,
          left: -85,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        SmallContiner(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: CircularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
  );
}