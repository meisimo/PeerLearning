import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/tutor_profile_page.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/widgets/layouts/card_layout.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';

class MiniCard extends StatefulWidget {
  final bool isPrimaryCard;
  final Color primary;
  final String imgPath;
  final String chipText1;
  final String chipText2;
  final String chipText3;
  final Widget backWidget;
  final Color chipColor;
  final UserModel tutor;

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

  @override
  MiniCardState createState() => MiniCardState();
}

class MiniCardState extends State<MiniCard> {
  double width;
  double lol;
  bool _checkConnection = true;
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
        height: widget.isPrimaryCard ? 190 : 180,
        imgPath: this.widget.imgPath,
        primary: this.widget.primary,
        backWidget: this.widget.backWidget,
        cardInfo: _cardInfo(
            widget.chipText1, widget.chipText2, LightColor.titleTextColor, widget.chipColor,
            isPrimaryCard: widget.isPrimaryCard
        ),
        sideInfo: TagChip( chipText3, Colors.blueGrey, height: 7, isPrimaryCard: true,),
      ),
      onTap: ()=> _handleConnectivity(onSuccess: (){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => new TutorProfilePage(tutor: this.widget.tutor))); 
      },onError: (){
          _showNotConnectedDialog(context);
      })
    );
  }

    void _showNotConnectedDialog(context) => showDialog(
      context: context,
      child: NotConnectedCard(tryToReconnect: () {
        Navigator.of(context).pop();
        setState(() {
          this._checkConnection = true;
        });
      }));

  void _handleConnectivity({Function onSuccess, Function onError}) =>
      handleConnectivity(
          onSuccess: onSuccess,
          onError: onError,
          onResponse: () => this._checkConnection = false);
}
