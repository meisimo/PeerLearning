import 'package:flutter/material.dart';
import 'package:peer_programing/src/widgets/layouts/circular_container.dart';
import 'package:peer_programing/src/widgets/layouts/small_container.dart';


class DecorationContainerA extends Stack {
  DecorationContainerA(primary, top, left) : super(
    children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: primary.withAlpha(255),
          ),
        ),
        SmallContiner(primary, 20, 40),
        Positioned(
          top: 20,
          right: -30,
          child: CircularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        )
      ],
  );
}
