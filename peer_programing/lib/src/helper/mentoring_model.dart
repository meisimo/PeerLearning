import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_type_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/utils/dev.dart';

const MENTORING_COLLECTION_NAME = "mentoring";

class Mentoring{
  //TODO: load the categories to store it in cache
  final id = 0;
  final String name;
  final String description;
  final double points;
  final List<dynamic> categoriesReference;
  List<MentoringCategory> categories;
  final DocumentReference mentoringTypeReference;
  MentoringType mentoringType;
  final DocumentReference userReference;
  UserModel user;
  DocumentReference selectedByReference;
  UserModel selectedBy;
  String lugar;
  int precio;
  final DocumentReference reference;

  Mentoring({
    this.name,
    this.description,
    this.points,
    this.categories,
    this.reference,
    this.userReference,
    this.categoriesReference,
    this.mentoringTypeReference,
    this.lugar,
    this.precio,
  });

  static listFromSnapshot(List<DocumentSnapshot> snapshots) =>
    snapshots.map((snap) async =>  ( await (new Mentoring.fromSnapshot(snap)).populate() ) ).toList();
    
  static Stream<QuerySnapshot> snapshots() => Firestore.instance.collection(MENTORING_COLLECTION_NAME).snapshots();

  Mentoring.fromMap(Map<String, dynamic> map, {this.reference})
    : assert( map['name'] != null),
      assert( map['description'] != null),
      assert( map['points'] != null),
      assert( map['categories'] != null),
      assert( map['mentoringType'] != null),
      assert( map['precio'] != null),
      assert( map['lugar'] != null),
      name = map['name'],
      description = map['description'],
      points = map['points'],
      categoriesReference = map['categories'].map( (cat) => cast<DocumentReference>(cat)).toList(),
      mentoringTypeReference = map['mentoringType'],
      userReference = map['user'],
      precio = map['precio'],
      lugar = map['lugar'];

  Mentoring.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, reference: snapshot.reference);


  static CollectionReference collection() => 
    Firestore.instance.collection(MENTORING_COLLECTION_NAME);

  static Query _whereOfAvilable(MentoringType mentoringType, UserModel user) => 
    collection().where('selectedBy', isNull: true).where('mentoringType', isEqualTo: mentoringType.reference);

  static Future<QuerySnapshot> whereOfAvilable(MentoringType mentoringType, UserModel user) async =>
    await _whereOfAvilable(mentoringType, user).getDocuments();

  static Future<QuerySnapshot> whereOfSelectedBy(UserModel user) async => 
    await collection().where('selectedBy', isEqualTo: user.reference).getDocuments();

  static Future<List<Mentoring>> getAvilables(MentoringType mentoringType, UserModel user) async => 
    await Future.wait( listFromSnapshot((await whereOfAvilable(mentoringType, user)).documents));

  static Future<List<Mentoring>> filterByTitle(MentoringType mentoringType, UserModel user, String title) async =>
    await Future.wait( listFromSnapshot((await _whereOfAvilable(mentoringType, user).where('name', isGreaterThanOrEqualTo: title  ).where('name', isLessThan: title+'z'  ).getDocuments()).documents));

  static Future<List<Mentoring>> filterByCategory(MentoringType mentoringType, UserModel user, List<MentoringCategory> categories) async =>
    await Future.wait( listFromSnapshot((await _whereOfAvilable(mentoringType, user).where('categories', arrayContainsAny: categories.map((cat)=>cat.reference).toList()).getDocuments()).documents));

  static Future<List<Mentoring>> filterByTitleAndCategory(MentoringType mentoringType, UserModel user, {String title, List<MentoringCategory> categories}) async =>
    await Future.wait( listFromSnapshot((await _whereOfAvilable(mentoringType, user)
      .where('name', isGreaterThanOrEqualTo: title  )
      .where('name', isLessThan: title+'z'  )
      .where('categories', arrayContainsAny: categories.map((cat)=>cat.reference).toList())
      .getDocuments()).documents));

  static Future<List<Mentoring>> filterBySelectedBy(UserModel user) async =>
    await Future.wait( listFromSnapshot((await whereOfSelectedBy(user)).documents));



  Future<Mentoring> populate() async{
    this.mentoringType = MentoringType.fromSnapshot(await mentoringTypeReference.get());
    this.user = UserModel.fromSnapshot(await userReference.get() );
    this.categories = [];
    for (DocumentReference category in categoriesReference){
      categories.add(new MentoringCategory.fromSnapshot(await category.get()));
    }
    return this;
  }

  Future<Mentoring> save() async{
    await Firestore.instance.collection(MENTORING_COLLECTION_NAME).add(this._toMap());
    return this;
  }

  Future<void> selectBy(UserModel user) async  =>
    await this.reference.updateData({'selectedBy': user.reference});

  Future<void> unselect() async => 
    await this.reference.updateData({'selectedBy': null});

  Map<String, dynamic> _toMap() => 
    {
      "name": this.name,
      "points": 1.1,
      "description": this.description,
      "mentoringType": this.mentoringTypeReference,
      "categories": this.categoriesReference,
      "lugar": this.lugar,
      "precio": this.precio,
      "user": this.userReference,
      "selectedBy": null
    };

  @override
  String toString() =>
    "\n{\n\t'name': '$name', \n\t'description': '$description', \n\t'points': '$points', \n\t'categories': '$categories', \n\t'mentoringType': '$mentoringType', \n\t'user': $user, \n\t'precio': $precio, \n\t'lugar': $lugar \n}";

}
class MentoringList {
  static Random rnd = Random();
/*   static List<Mentoring> all() => [
        Mentoring(
          id: 1,
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 2,
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 3,
          name: "Machine Learning",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 4,
          name: "Big Data",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 5,
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 6,
          name: "Machine Learning",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 7,
          name: "Big Data",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 8,
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 9,
          name: "Machine Learning",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          id: 10,
          name: "Big Data",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
      ];
 */
  static List<Mentoring> all() => [];

  static Mentoring getById({int id}) =>
      MentoringList.all().where((Mentoring m) => m.id == id).toList()[0];
}
