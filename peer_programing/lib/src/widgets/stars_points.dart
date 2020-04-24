import 'package:flutter/material.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';

class StartsPoints extends StatelessWidget{
  final int maxScore;
  final double score;
  final Color color;

  StartsPoints(this.maxScore, this.score, {this.color = LightColor.orange})
    :assert( score.ceil() <= maxScore);

  Icon _fullStar() =>  Icon(
    Icons.star,
    color: this.color
  );

  Icon _halfStar() => Icon(
    Icons.star_half,
    color: this.color
  );

  Icon _emptyStar() => Icon(
    Icons.star_border,
    color: this.color
  );

  @override
  Widget build(BuildContext context){
    List<Icon> stars = List<Icon>.filled(this.score.floor(), _fullStar(), growable: true);
    
    if( 0.5 <= this.score - this.score.floor() )
      stars.add(_halfStar());

    stars.addAll( List<Icon>.filled(this.maxScore-stars.length, _emptyStar()) );

    return Row(children: stars);
  }
}