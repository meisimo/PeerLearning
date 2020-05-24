
import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class MentoringPoints extends StatelessWidget{
  double points;
  Color  background;

  MentoringPoints(double this.points, Color this.background);

  @override
  Widget build(BuildContext context) => 
  Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 3,
            backgroundColor: background,
          ),
          SizedBox(
            width: 5,
          ),
          Text("$points",
              style: TextStyle(
                color: LightColor.grey,
                fontSize: 14,
              ))
        ],
      ));
}