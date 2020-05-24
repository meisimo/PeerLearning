import 'package:flutter/material.dart';
import 'package:peer_programing/src/utils/dev.dart';

const LONG_TEXT_MAX_LENGTH = 25;
const TEXT_MAX_LENGTH = 10;

class TagChip extends StatelessWidget {
  final String text;
  final Color textColor;
  final double height;
  final bool isPrimaryCard;
  final int id;
  final Function onTap;
  final double dividerWidth;
  final bool usePadding, chipConstraints;

  TagChip(this.text, this.textColor,
      {this.height = 0, this.isPrimaryCard = false, this.id, this.onTap, this.dividerWidth=1, this.usePadding = false, this.chipConstraints = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: this.usePadding ? EdgeInsets.symmetric(horizontal: dividerWidth, vertical: 3): EdgeInsets.symmetric(horizontal: dividerWidth),
        child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: height),
        constraints: chipConstraints ? BoxConstraints( maxWidth: 100, minWidth: 50 ): null,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
        ),
        child: Text(
          chipConstraints ? truncateText(text, TEXT_MAX_LENGTH): truncateText(text, LONG_TEXT_MAX_LENGTH),
          style: TextStyle(
              color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
        ),
      ),
    ));
  }
}
