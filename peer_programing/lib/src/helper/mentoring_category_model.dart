import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:flutter/cupertino.dart';

const MENTORING_CATEGORY_COLLECTION_NAME = "mentoring-category";

class MentoringCategory {
  final int id;
  final String name;
  final Color color;
  final DocumentReference reference;

  MentoringCategory({this.id, this.name, this.color, this.reference});

  MentoringCategory.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['name'] != null),
        assert(map['color'] != null),
        id = 0,
        name = map['name'],
        color = MentoringCategory.generateColor(map['color']);

  MentoringCategory.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  static listFromSnapshot(List<DocumentSnapshot> snapshots) => snapshots
      .map((snapshot) => new MentoringCategory.fromSnapshot(snapshot))
      .toList();

  static getCategoriesFromDoc(snap) async {
    List<MentoringCategory> categories = List();
    Color docColor;
    MentoringCategory cat;
    await snap.documents.forEach((doc) => ((doc.data['categories']
        .forEach((categorie) => categorie.get().then((subDoc) => {
              docColor = generateColor(subDoc.data['color']),
              cat =
                  MentoringCategory(name: subDoc.data['name'], color: docColor),
              categories.add(cat),
            })))));
    return categories;
  }

  static generateColor(colorString) {
    switch (colorString) {
      case "yellow":
        return LightColor.yellow;
      case "ligthBlue":
        return LightColor.lightBlue;
      case "lightseeBlue":
        return LightColor.lightseeBlue;
      case "darkPurple":
        return LightColor.darkpurple;
      case "orange":
        return LightColor.orange;
      case "grey":
        return LightColor.grey;
    }
  }

  static Stream<QuerySnapshot> snapshots() => Firestore.instance
      .collection(MENTORING_CATEGORY_COLLECTION_NAME)
      .snapshots();

  static Future<List<MentoringCategory>> all() async =>
      (await Firestore.instance.collection(MENTORING_CATEGORY_COLLECTION_NAME).getDocuments()).documents.map( (DocumentSnapshot category) => new MentoringCategory.fromSnapshot(category)).toList();

  @override
  String toString() {
    return "{'id':$id, 'name':$name, 'color':$color, }";
  }
}

class MentoringCategoryList {
  static List<MentoringCategory> all() => [
        MentoringCategory(id: 0, name: 'Matemática', color: LightColor.yellow),
        MentoringCategory(id: 1, name: 'ALgoritmo', color: LightColor.seeBlue),
        MentoringCategory(
            id: 2, name: 'Ing. Software', color: LightColor.orange),
        MentoringCategory(id: 3, name: 'Cálculo I', color: LightColor.grey),
        MentoringCategory(
            id: 4, name: 'Integrales', color: LightColor.lightBlue),
        MentoringCategory(
            id: 5, name: 'Ingles', color: LightColor.lightseeBlue),
        MentoringCategory(
            id: 6, name: 'Estadistica', color: LightColor.darkpurple),
        MentoringCategory(
            id: 7, name: 'Literatura', color: LightColor.lightseeBlue),
      ];

  static List<MentoringCategory> randGenerate(int cant) {
    List list = List<MentoringCategory>(cant);
    Random randGen = new Random();

    for (int i = 0; i < cant; i++) {
      list[i] = all()[randGen.nextInt(all().length)];
    }

    return list;
  }
}
