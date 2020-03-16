
import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/widgets/tarjetas/extended_card.dart';

class MiniCard extends StatelessWidget{
  final bool isPrimaryCard;
  final Color primary;
  final String imgPath;
  final String chipText1;
  final String chipText2;
  final Widget backWidget;
  final Color chipColor;

  double width;

  MiniCard({
    this.primary = Colors.redAccent,
    this.imgPath,
    this.chipText1 = '',
    this.chipText2 = '',
    this.backWidget,
    this.chipColor = LightColor.orange,
    this.isPrimaryCard = false
  });

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isPrimaryCard ? Colors.white : textColor),
            ),
          ),
          SizedBox(height: 5),
          TagChip(courses, primary, height: 5, isPrimaryCard: isPrimaryCard)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    width = MediaQuery.of(context).size.width;
    return CardLayout(
      height: isPrimaryCard ? 190 : 180,
      imgPath: this.imgPath,
      primary: this.primary,
      backWidget: this.backWidget,
      cardInfo: _cardInfo(
        chipText1,
        chipText2,
        LightColor.titleTextColor,
        chipColor,
        isPrimaryCard: isPrimaryCard
      ),
    );
  }
}