
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/helper/auth_module.dart';

import '../../routes.dart';

const USER_COLLECTION_NAME = 'user';

class UserModel{
  final int id;
  final String name;
  final double points;
  final String imgPath;
  final String emal = "johanneira902@gmail.com";
  final DocumentReference reference;
  static final BasicAuth auth = Routes.auth;

  UserModel({
    this.id = 0, 
    this.name,
    this.points,
    this.imgPath,
    this.reference
  });

  UserModel.fromMap(Map<String, dynamic> map, {this.reference})
    : assert(map['name'] != null),
      assert(map['points'] != null),
      id = 0,
      name = map['name'],
      points = map['points'],
      imgPath = map['imgPath'] != null ? map['imgPath'] : "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg";

  UserModel.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromMap(snapshot.data, reference:snapshot.reference);

  static Future<UserModel> getOne() async {
    return new UserModel.fromSnapshot((await Firestore.instance.collection(USER_COLLECTION_NAME).getDocuments()).documents[0]);
  }

  static Future<UserModel> getCurrentUser() async {
    var user = await auth.getCurrentUser();
    if(user.uid != null){
      var query = await Firestore.instance.collection(USER_COLLECTION_NAME).where('authId', isEqualTo: user.uid).getDocuments();   
      return new UserModel.fromSnapshot(query.documents.first);
    }
    return null;
  }

  @override
  String toString(){
    return "{'name':$name 'points':$points}";
  }
}

class UserModelList{
  static final List<UserModel> _all = [
    // UserModel(
    //   id: 0,
    //   name: "Naruto",
    //   points: 4.3,
    //   imgPath: "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg",
    // ),
    // UserModel(
    //   id: 1,
    //   name: "Sasuke",
    //   points: 4.3,
    //   imgPath: "https://hips.hearstapps.com/esquireuk.cdnds.net/16/39/980x980/square-1475143834-david-gandy.jpg?resize=480:*",
    // )
  ];

  static UserModel randGenerate(){
    Random randGen = new Random();
    return _all[randGen.nextInt(_all.length)];
  }
}