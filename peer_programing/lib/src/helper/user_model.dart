
import 'dart:math';

class UserModel{
  final int id;
  final String name;
  final double points;
  final String imgPath;

  UserModel({
    this.id, 
    this.name,
    this.points,
    this.imgPath,
  });

  @override
  String toString(){
    return "{'id':$id, 'name':$name}";
  }
}

class UserModelList{
  static final List<UserModel> _all = [
    UserModel(
      id: 0,
      name: "Naruto",
      points: 4.3,
      imgPath: "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg",
    ),
    UserModel(
      id: 1,
      name: "Sasuke",
      points: 4.3,
      imgPath: "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*",
    )
  ];

  static UserModel randGenerate(){
    Random randGen = new Random();
    return _all[randGen.nextInt(_all.length)];
  }
}