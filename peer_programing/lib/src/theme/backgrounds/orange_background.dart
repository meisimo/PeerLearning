import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class OrangeBackground extends StatelessWidget{
  final double width;
  final double height;
  final Widget child;

  OrangeBackground({this.width, this.height, this.child});

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
      return Container(
        height: height,
        width: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: borderColor, width: borderWidth),
        ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Container(
      height: this.height,
      width: this.width,
      decoration: BoxDecoration(color: LightColor.orange),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: this.height * 0.30,
            right: -this.height,
            child: _circularContainer( this.height * 2.5, LightColor.lightOrange2),
          ),
          Positioned(
            top: -this.height * 0.5,
            left: -this.height * 0.51,
            child: _circularContainer(width * .5, LightColor.darkOrange)
          ),
          Positioned(
            top: -this.height * 1.8,
            right: -this.height * 0.25,
            child: _circularContainer(width * .7, Colors.transparent,borderColor: Colors.white38)
          ),
          Positioned(
            top: 50,
            left: 0,
            child: this.child,
          )  
        ],
      ),
    );
  }
}