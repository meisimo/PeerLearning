import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/backgrounds/orange_background.dart';

class MainHeader extends StatelessWidget{
  double width;
  final String title;

  MainHeader({this.title});

  @override
  Widget build(BuildContext context){
    this.width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)
      ),
      child: OrangeBackground(
        width:this.width,
        height: 120,
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Stack(
            children: <Widget>[
              Icon(
                Icons.keyboard_arrow_left,
                color: Colors.white,
                size: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  this.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
                  )
                )
            ],)
          )
        ),
      );
  }
}