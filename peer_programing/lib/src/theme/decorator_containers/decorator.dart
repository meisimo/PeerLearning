import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_a.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_b.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_c.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_d.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_e.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_f.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_g.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_i.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator_h.dart';

class Decorator{
  static Stack generateDecoration({double top = 50, double left = -30} ){
    double rand = (new Random()).nextDouble();

    if( rand < 0.11 )
      return new DecorationContainerA(LightColor.lightOrange, top, left);
    if ( rand < 0.22 )
      return new DecorationContainerB(Colors.white, top, left);
    if (rand < 0.33 )
      return new DecorationContainerC(Colors.white, top, left);
    if (rand < 0.44 )
      return new DecorationContainerD(LightColor.seeBlue, top, left,
        secondary: LightColor.lightseeBlue,
        secondaryAccent: LightColor.darkseeBlue
      );
    if (rand < 0.55 )
      return new DecorationContainerE(LightColor.lightpurple,top,left,
        secondary: LightColor.lightseeBlue);
    if (rand < 0.66 )
      new DecorationContainerF(LightColor.lightOrange, LightColor.orange, top, left);
    if (rand < 0.77)
      new DecorationContainerG();
    if (rand < 0.88)
      new DecorationContainerH();
    return new DecorationContainerI();
  }
}