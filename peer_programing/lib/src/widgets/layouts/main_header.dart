import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/backgrounds/orange_background.dart';

class MainHeader extends StatelessWidget{
  double width;
  double height;

  final bool goBack;
  final String title;
  final Widget child;

  MainHeader({this.title, this.goBack = false, this.child, this.height = 120});

  List<Widget> _headerContent(){
    List contet = <Widget>[];
    
    if (this.goBack){
      contet.add(
        Icon(
          Icons.keyboard_arrow_left,
          color: Colors.white,
          size: 40,
        )
      );
    }
    
    contet.add(
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
    );

    if (this.child != null){
      print(500);
      contet.add(SizedBox(height: 10,));
      contet.add(this.child);
    }

    return contet;
  }

  @override
  Widget build(BuildContext context){
    this.width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)
      ),
      child: OrangeBackground(
        width:this.width,
        height: this.height,
        child: Container(
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column( children: this._headerContent() )
          )
        ),
      );
  }
}