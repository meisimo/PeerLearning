import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;
  final Color textColor;
  final double height;
  final bool isPrimaryCard;
  final int id;
  final Function onTap;

  TagChip(this.text, this.textColor,
      {this.height = 0, this.isPrimaryCard = false, this.id, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
