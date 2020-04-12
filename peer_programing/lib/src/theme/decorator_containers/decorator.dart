import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_a.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_b.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_c.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_d.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_e.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_f.dart';

class Decorator{
  static Stack generateDecoration({double top = 50, double left = -30} ){
    double rand = (new Random()).nextDouble();

    if( rand < 0.165 )
      return new DecorationContainerA(LightColor.lightOrange, top, left);
    if ( rand < 0.33 )
      return new DecorationContainerB(Colors.white, top, left);
    if (rand < 0.495 )
      return new DecorationContainerC(Colors.white, top, left);
    if (rand < 0.66 )
      return new DecorationContainerD(LightColor.seeBlue, top, left,
        secondary: LightColor.lightseeBlue,
        secondaryAccent: LightColor.darkseeBlue
      );
    if (rand < 0.825 )
      return new DecorationContainerE(LightColor.lightpurple,top,left,
        secondary: LightColor.lightseeBlue);
    return new DecorationContainerF(LightColor.lightOrange, LightColor.orange, top, left);
  }
}