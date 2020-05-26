import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/tutor_profile_page.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/widgets/layouts/card_layout.dart';

class MiniCard extends StatelessWidget {
  final bool isPrimaryCard;
  final Color primary;
  final String imgPath;
  final String chipText1;
  final String chipText2;
  final String chipText3;
  final Widget backWidget;
  final Color chipColor;
  final UserModel tutor;

  double width;

  MiniCard(
      {this.primary = Colors.redAccent,
      this.imgPath,
      this.chipText1 = '',
      this.chipText2 = '',
      this.chipText3 = '',
      this.backWidget,
      this.chipColor = LightColor.orange,
      this.tutor,
      this.isPrimaryCard = false
  });

  Widget _cardInfo(String title, String courses, Color textColor, Color primary,
      {bool isPrimaryCard = false}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.horizontal( left: Radius.circular(15))
            ),
            padding: EdgeInsets.only(right: 10),
            margin: EdgeInsets.only(left: 10),
            width: width * .36,
            alignment: Alignment.topCenter,
            child: Text( truncateText(title, 15),
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
          SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.horizontal( right: Radius.circular(15))
            ),
            padding: EdgeInsets.only(left: 10),
            width: width * .32,
            alignment: Alignment.topCenter,
            child: Text(
              courses,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
            ),
          ),
        ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: CardLayout(
        height: isPrimaryCard ? 190 : 180,
        imgPath: this.imgPath,
        primary: this.primary,
        backWidget: this.backWidget,
        cardInfo: _cardInfo(
            chipText1, chipText2, LightColor.titleTextColor, chipColor,
            isPrimaryCard: isPrimaryCard
        ),
        sideInfo: TagChip( chipText3, Colors.blueGrey, height: 7, isPrimaryCard: true,),
      ),
      onTap: (() => Navigator.push(context, new MaterialPageRoute(builder: (context) => new TutorProfilePage(tutor: this.tutor)))),
    );
  }
}
