
import 'package:flutter/material.dart';
import 'package:peer_programing/src/pages/mentoring_extended_card.dart';
import 'package:peer_programing/src/theme/theme.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/layouts/card_layout.dart';

class MicroCard extends StatelessWidget{
  final Color primary;
  final String imgPath;
  final Widget backWidget;
  final int mentoringId;

  double width;

  MicroCard({
    this.primary = Colors.redAccent,
    this.imgPath,
    this.backWidget,
    this.mentoringId,
  });

  Widget _cardContent({
    String title,
    double points,
  }){
    return Container(
      child: 
      Column(
        children:<Widget>[
          Row (
          children: <Widget>[
            Icon(Icons.star, size: 1,),
            Text("$points", style: AppTheme.h6Style.copyWith(
              fontSize: 1, 
              color: LightColor.extraDarkPurple
              ),
            ),
          ])
        ]
      )
    );
  }

  @override
  Widget build(BuildContext context){
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: CardLayout(
        height: 100,
        imgPath: this.imgPath,
        primary: this.primary,
        backWidget: this.backWidget,
        cardInfo: _cardContent(
          points: 4.8,
          title: "nombre"
        ),
      ),
    );
  }
}