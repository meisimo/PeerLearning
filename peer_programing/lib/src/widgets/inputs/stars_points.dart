import 'package:flutter/cupertino.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class StarsPoints extends StatefulWidget{
  final double _initialRating;
  final Widget _inputText;
  final Function _onChange;

  StarsPoints({
    @required double initialRating,
    @required Widget inputText,
    @required Function onChange,
  }):
    _initialRating = initialRating,
    _inputText = inputText,
    _onChange = onChange;
  
  _StarsPoints createState() => new _StarsPoints(
    initialRating: _initialRating,
    inputText: _inputText,
    onChange: _onChange,
  );
}

class _StarsPoints extends State<StarsPoints>{
  final double _initialRating;
  final Widget _inputText;
  final Function _onChange;

  _StarsPoints({
    @required double initialRating,
    @required Widget inputText,
    @required Function onChange,
  }):
    _initialRating = initialRating,
    _inputText = inputText,
    _onChange = onChange;
  

  @override
  Widget build(BuildContext context) => Container(
      child: Column(
        children: <Widget>[
          _inputText,
          SmoothStarRating(
            allowHalfRating: true,
            onRatingChanged: (double v){
              _onChange(v);
              setState((){print("object");});
            },
            starCount: 5,
            rating: _initialRating,
            size: 35.0,
            color: LightColor.orange,
            borderColor: LightColor.orange,
            spacing:0.0
          )
        ],
      ),
    );
}