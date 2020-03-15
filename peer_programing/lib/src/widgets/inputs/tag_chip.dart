import 'package:flutter/material.dart';

class TagChip extends StatelessWidget{
  final String text;
  final Color textColor;
  final double height;
  final bool isPrimaryCard;

  TagChip(
    this.text, 
    this.textColor,
    {
      this.height = 0,
      this.isPrimaryCard = false,
    }
  );

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }
}