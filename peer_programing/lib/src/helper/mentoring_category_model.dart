import 'dart:math';

import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:flutter/cupertino.dart';

class MentoringCategory{
  final int id;
  final String name;
  final Color color;

  MentoringCategory({this.id, this.name, this.color});

  @override
  String toString(){
    return "{'id':$id, 'name':$name, 'color':$color, }";
  }
}

class MentoringCategoryList{
  static List<MentoringCategory> all() => [
    MentoringCategory(id:0, name:'Matemática',    color: LightColor.yellow),
    MentoringCategory(id:1, name:'ALgoritmo',     color: LightColor.seeBlue),
    MentoringCategory(id:2, name:'Ing. Software', color: LightColor.orange),
    MentoringCategory(id:3, name:'Cálculo I',     color: LightColor.grey),
    MentoringCategory(id:4, name:'Integrales',    color: LightColor.lightBlue),
    MentoringCategory(id:5, name:'Ingles',        color: LightColor.lightseeBlue),
    MentoringCategory(id:6, name:'Estadistica',   color: LightColor.darkpurple),
    MentoringCategory(id:7, name:'Literatura',    color: LightColor.lightseeBlue),
  ];

  static List<MentoringCategory> randGenerate(int cant){
    List list = List<MentoringCategory>(cant);
    Random randGen = new Random();

    for(int i = 0; i<cant; i++  ){
      list[i] = all()[randGen.nextInt(all().length)];
    }
    
    return list;
  }
}