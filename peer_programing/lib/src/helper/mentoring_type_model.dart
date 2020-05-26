import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

const MENTORING_TYPE_COLLECTION_NAME = "mentoring-type";

class MentoringType {
  static final String SOLICITUD = "solicitud";
  static final String TUTORIA = "tutoría";
  final String _name;
  final DocumentReference reference;

  String get name => this._name;

  MentoringType( this._name, {this.reference});

  MentoringType.fromMap(Map<String, dynamic> map, {this.reference})
    :assert(map['name'] != null),
    _name = map['name'];

  MentoringType.fromSnapshot(DocumentSnapshot snapshot):
    this.fromMap(snapshot.data, reference: snapshot.reference);

  static CollectionReference collection() => 
    Firestore.instance.collection(MENTORING_TYPE_COLLECTION_NAME);

  static Stream<QuerySnapshot> snapshot() =>
    collection().snapshots();

  @override
  String toString() {
    return "{'name':$_name}";
  }

  static List<MentoringType> listFromSnapshot(List<DocumentSnapshot> snapshots) => 
    snapshots.map((snap) => new MentoringType.fromSnapshot(snap)).toList();

  static Map<String, MentoringType> mapMentoringTypes(List<MentoringType> mentoringTypes) => 
    {
      'learn': mentoringTypes[mentoringTypes.indexWhere((MentoringType mentoring) => mentoring.name == SOLICITUD)],
      'teach': mentoringTypes[mentoringTypes.indexWhere((MentoringType mentoring) => mentoring.name == TUTORIA)],
    };

  static all() async =>
    listFromSnapshot((await collection().getDocuments()).documents);
  

  // static getDocsOfDoc(doc) async {
  //   MentoringType type;
  //   await doc.data['mentoringType'].get().then((subDoc) => (
  //         type = MentoringType(
  //             subDoc.documentID == "VQiH1ylNHJ4roav0FAeE " ? 1 : 0,
  //             subDoc.data['name'])
  //   ));
  //   return type;
  // }
  
}

class MentoringTypeList {
  static final List<MentoringType> _all = [
    // MentoringType(0, 'Tutoría'),
    // MentoringType(1, 'Solicitud de tutoría'),
  ];

  static MentoringType randGenerate() {
    Random randGen = new Random();
    return _all[randGen.nextInt(_all.length)];
  }
}
