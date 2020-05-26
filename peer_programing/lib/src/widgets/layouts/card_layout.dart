import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class CardLayout extends StatelessWidget{
  final double rate = 0.73143; 
  final double radiusRate = 0.111;
  final double height;
  final Color primary;
  final String imgPath;
  final Widget backWidget;
  final Widget cardInfo;
  final Widget sideInfo;

  double width;
  double radius;

  CardLayout({
    this.cardInfo,
    this.height,
    this.primary = Colors.redAccent,
    this.imgPath,
    this.backWidget,
    this.sideInfo = null,
  }){
    this.width = this.rate*this.height;
    this.radius = max(this.height*this.radiusRate, 20);
  }

  @override
  Widget build(BuildContext context){
    return Container(
        height: this.height,
        width: this.width,
        margin: EdgeInsets.symmetric(
          horizontal: 10, 
          vertical: 20
        ),
        decoration: BoxDecoration(
          color: primary.withAlpha(200),
          borderRadius: BorderRadius.all(Radius.circular(this.radius)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10,
              color: LightColor.lightpurple.withAlpha(20)
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(this.radius)),
          child: Container(
            child: Stack(
              children: <Widget>[
                backWidget,
                Positioned(
                  top: 20,
                  left: 10,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: NetworkImage(imgPath),
                    radius: this.radius,
                  )
                ),
                this.sideInfo != null ? 
                Positioned(
                  top: 20,
                  right: 5,
                  child: this.sideInfo
                ): Text(''),
                Positioned(
                  bottom: 15,
                  child: cardInfo,
                )
              ],
            ),
          ),
        )
      );
  }
}