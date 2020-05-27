import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_type_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:peer_programing/src/utils/dev.dart';

const MENTORING_COLLECTION_NAME = "mentoring";

class Mentoring{
  final id = 0;
  final DocumentReference reference;

  String name;
  String description;
  double points;
  List<dynamic> categoriesReference;
  List<MentoringCategory> categories;
  DocumentReference mentoringTypeReference;
  MentoringType mentoringType;
  DocumentReference userReference;
  UserModel user;
  DocumentReference selectedByReference;
  UserModel selectedBy;
  String lugar;
  int precio;
  bool closed, successfull;
  

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
      assert( map['categories'] != null),
      assert( map['mentoringType'] != null),
      assert( map['precio'] != null),
      assert( map['lugar'] != null),
      name = map['name'],
      description = map['description'],
      categoriesReference = map['categories'].map( (cat) => cast<DocumentReference>(cat)).toList(),
      mentoringTypeReference = map['mentoringType'],
      userReference = map['user'],
      selectedByReference = map['selectedBy'],
      precio = map['precio'],
      lugar = map['lugar'],
      successfull = map['successfull'];

  Mentoring.fromSnapshot(DocumentSnapshot snapshot)
    :this.fromMap(snapshot.data, reference: snapshot.reference);


  static CollectionReference collection() => 
    Firestore.instance.collection(MENTORING_COLLECTION_NAME);

  static Query _whereOfAvilable(MentoringType mentoringType, UserModel user) => 
    collection().where('selectedBy', isNull: true).where('closed', isEqualTo: false).where('mentoringType', isEqualTo: mentoringType.reference);

  static Future<QuerySnapshot> whereOfAvilable(MentoringType mentoringType, UserModel user) async =>
    await _whereOfAvilable(mentoringType, user).getDocuments();

  static Future<QuerySnapshot> whereOfSelectedBy(UserModel user, {bool closed=false}) async => 
    await collection().where('selectedBy', isEqualTo: user.reference).where('closed',isEqualTo: closed).getDocuments();

  static Future<QuerySnapshot> whereOfCreatedBy(UserModel user, {bool closed = false, bool successfull = false}) async => 
    await collection().where('user', isEqualTo: user.reference).where('closed', isEqualTo: closed).where('successfull', isEqualTo: successfull).getDocuments();

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

  static Future<List<Mentoring>> filterByCreatedBy(UserModel user) async =>
    await Future.wait( listFromSnapshot((await whereOfCreatedBy(user)).documents));

  Future<Mentoring> populate() async{
    this.mentoringType = MentoringType.fromSnapshot(await mentoringTypeReference.get());
    this.user = UserModel.fromSnapshot(await userReference.get() );
    this.points = this.user.points;
    this.categories = [];
    this.selectedBy = this.selectedByReference ==  null ? null : UserModel.fromSnapshot(await selectedByReference.get() );
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

  Future<void> unselect() async{
    this.selectedBy = null;
    await this.reference.updateData({'selectedBy': null});
  }

  Future<void> disable() async =>
    await this.reference.updateData({'closed': true});

  Future<void> markAsSuccessful() async =>
    await this.reference.updateData({'successfull': true});

  Future<void> update() async{
    await this.reference.updateData({
      'name':this.name,
      'description':this.description,
      'precio':this.precio,
      'lugar':this.lugar,
      'mentoringType':this.mentoringTypeReference,
      'categories':this.categoriesReference,
    });
  }

  Future<void> sendFeedBack({double calification, String comments}) async {
    return await Future.wait(<Future>[
      this.user.addFeedback(coment: comments, calification:calification),
      this.reference.updateData({'closed': true})
    ]);
  }

  Map<String, dynamic> _toMap() => 
    {
      "name": this.name,
      "description": this.description,
      "mentoringType": this.mentoringTypeReference,
      "categories": this.categoriesReference,
      "lugar": this.lugar,
      "precio": this.precio,
      "user": this.userReference,
      "selectedBy": null,
      "closed": false,
      "successfull": false
    };

  @override
  String toString() =>
    "\n{\n\t'name': '$name', \n\t'description': '$description', \n\t'points': '$points', \n\t'categories': '$categories', \n\t'mentoringType': '$mentoringType', \n\t'user': $user, \n\t'precio': $precio, \n\t'lugar': $lugar \n}";

}