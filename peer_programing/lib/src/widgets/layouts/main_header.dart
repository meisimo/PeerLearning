import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/backgrounds/orange_background.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class MainHeader extends StatelessWidget {
  double width;
  double height;

  final bool goBack;
  final String title;
  final Widget child;

  MainHeader({this.title, this.goBack = false, this.child, this.height = 120});

  Widget _gobackTitle(BuildContext context) => Align(
      alignment: Alignment.topCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Align(
              alignment: Alignment.topLeft,
              child: MaterialButton(
                minWidth: 40,
                splashColor: LightColor.lightOrange2,
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colors.white,
                  size: 40,
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              this.title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ));

  Widget _simpleTile() => Align(
      alignment: Alignment.center,
      child: Text(
        this.title,
        style: TextStyle(
            color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
      ));

  List<Widget> _headerContent(BuildContext context) {
    List contet = <Widget>[];

    contet.add(this.goBack ? _gobackTitle(context) : _simpleTile());

    if (this.child != null) {
      contet.add(SizedBox(
        height: 10,
      ));
      contet.add(this.child);
    }

    return contet;
  }

  @override
  Widget build(BuildContext context) {
    this.width = MediaQuery.of(context).size.width;
    return ClipRRect(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
      child: OrangeBackground(
          width: this.width,
          height: this.height,
          child: Container(
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: this._headerContent(context)))),
    );
  }
}
