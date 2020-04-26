import 'dart:math';

import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_type_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mentoring {
  String name;
  String description;
  double points;
  List<MentoringCategory> categories;
  MentoringType mentoringType;
  UserModel user;

  Mentoring({
    this.name,
    this.description,
    this.points,
    this.categories,
    this.mentoringType,
    this.user,
  });

  @override
  String toString() {
    return "\n{\n\t'name': '$name', \n\t'description': '$description', \n\t'points': '$points', \n\t'categories': '$categories', \n\t'mentoringType': '$mentoringType', \n}";
  }

  static getDocsFormDb() async {
    String docName;
    double docPonts;
    MentoringType docType;
    String docDesc;
    List<MentoringCategory> docCat;
    List<Mentoring> mentoringList = List();

    await Firestore.instance
        .collection("mentoring")
        .getDocuments()
        .then((snap) => {
              snap.documents.forEach((doc) async => {
                    docCat = await MentoringCategory.getCategoriesFromDoc(snap),
                    docType = await MentoringType.getDocsOfDoc(doc),
                    docName = doc.data['name'],
                    docPonts = 0.0 + doc.data['points'],
                    docDesc = doc.data['description'],
                    mentoringList.add(new Mentoring(
                        name: docName,
                        description: docDesc,
                        points: docPonts,
                        mentoringType: docType,
                        categories: docCat)),
                    print(mentoringList)
                  }),
            });
            return mentoringList;
  }
}

class MentoringList {
  static Random rnd = Random();
  static List<Mentoring> all() => [
        Mentoring(
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Machine Learning",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Big Data",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Machine Learning",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Big Data",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Data Science",
          description:
              "Launch your career in data science. A sweet-cource introduction to data science, develop and taught by leading professors.",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Machine Learning",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
        Mentoring(
          name: "Big Data",
          description:
              "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
          points: rnd.nextInt(10) * 0.5,
          categories: MentoringCategoryList.randGenerate(rnd.nextInt(4) + 1),
          mentoringType: MentoringTypeList.randGenerate(),
          user: UserModelList.randGenerate(),
        ),
      ];
}
