import 'package:flutter/material.dart';

class Finder extends StatelessWidget {
  final TextStyle textStyle;
  final String placeholder;
  final Function onChange;

  Finder({this.textStyle, this.placeholder, this.onChange}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: TextField(
                  autocorrect: true,
                  maxLines: 1,
                  showCursor: false,
                  style: this.textStyle,
                  decoration: InputDecoration(
                      hintText: this.placeholder, hintStyle: this.textStyle),
                  onChanged: this.onChange,
                ),
              ),
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ],
      ),
    );
  }
}
