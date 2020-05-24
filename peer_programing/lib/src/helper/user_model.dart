
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:peer_programing/src/helper/auth_module.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/utils/dev.dart';

import '../../routes.dart';

const USER_COLLECTION_NAME = 'user';

class UserModel{
  final int id;
  final DocumentReference reference;
  final List<dynamic> califications;
  final int createdMentorings;
  static final BasicAuth auth = Routes.auth;

  List categoriesReference;
  String name;
  String imgPath;
  List<MentoringCategory> categories;
  FirebaseUser _userAuth;
  
  String get email => _userAuth.email;
  get points => _averageCalification();

  double _averageCalification(){
    if ( califications == null || califications.length == 0)
      return 0;
    
    double sum = 0;
    califications.forEach((calification) => sum += calification['points']);
    
    return truncateDouble( sum/califications.length, 1);
  }

  UserModel({
    this.id = 0, 
    this.name,
    this.imgPath,
    this.reference,
    this.califications=const [],
    this.createdMentorings,
    this.categoriesReference
  });

  UserModel.fromMap(Map<String, dynamic> map, {this.reference, FirebaseUser userAuth})
    : assert(map['name'] != null),
      assert(map['points'] != null),
      id = 0,
      name = map['name'],
      imgPath = map['imgPath'] != null ? map['imgPath'] : "https://jshopping.in/images/detailed/591/ibboll-Fashion-Mens-Optical-Glasses-Frames-Classic-Square-Wrap-Frame-Luxury-Brand-Men-Clear-Eyeglasses-Frame.jpg",
      _userAuth = userAuth,
      createdMentorings = map['createdMentorings'] == null ? 0 : map['createdMentorings'],
      califications = map['califications'] == null ? []: map['califications'],
      categoriesReference = map['categories'] == null ? []: map['categories'];

  UserModel.fromSnapshot(DocumentSnapshot snapshot, {FirebaseUser userAuth})
    : this.fromMap(snapshot.data, reference:snapshot.reference, userAuth: userAuth);

  static Future<UserModel> getCurrentUser() async {
    FirebaseUser userAuth = await auth.getCurrentUser();
    if(userAuth != null && userAuth.uid != null){
      var query = await Firestore.instance.collection(USER_COLLECTION_NAME).where('authId', isEqualTo: userAuth.uid).getDocuments();   
      return new UserModel.fromSnapshot(query.documents.first, userAuth: userAuth);
    }
    return null;
  }

  static Stream<QuerySnapshot> snapshot() =>
    Firestore.instance.collection(USER_COLLECTION_NAME).snapshots();

  static Stream<QuerySnapshot> recomendenMentorsSnapshot() =>
    Firestore.instance.collection(USER_COLLECTION_NAME).orderBy('points', descending:true).snapshots();

  static listFromSnapshot(List<DocumentSnapshot> snapshots) =>
    snapshots.map((snap) async =>  ( (new UserModel.fromSnapshot(snap)) ) ).toList();
    

  Future<void> addFeedback({String coment, double calification}) {
    califications.add({'coment':coment, 'points':calification});
    return Future.wait(<Future>[
      reference.updateData({'califications': califications}),
      reference.updateData({'points': _averageCalification()}),
    ]);
  }

  Future updateUser(){
    this.categoriesReference = categories == null ? [] : categories.map<DocumentReference>((cat) => cat.reference).toList();
    return Future.wait(<Future>[
      reference.updateData({'categories': this.categoriesReference}),
      reference.updateData({'name': name}),
    ]);
  }

  Future<UserModel> populate() async{
    categories = <MentoringCategory>[];
    for (DocumentReference category in categoriesReference){
      categories.add(new MentoringCategory.fromSnapshot(await category.get()));
    }
    return this;
  }

  Future<void> addMentoring() {
    return Future.wait(<Future>[
      reference.updateData({'createdMentorings': createdMentorings+1}),
    ]);
  }

  Future<void> removeMentoring() {
    return Future.wait(<Future>[
      reference.updateData({'createdMentorings': createdMentorings-1}),
    ]);
  }

  Future<void> signOut() =>
    (new Auth()).signOut();
  

  @override
  String toString(){
    return "{'name':$name 'points':$points}";
  }
}

class UserModelList{
  static final List<UserModel> _all = [
  ];

  static UserModel randGenerate(){
    Random randGen = new Random();
    return _all[randGen.nextInt(_all.length)];
  }
}