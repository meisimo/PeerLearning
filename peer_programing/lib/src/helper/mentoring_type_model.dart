import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MentoringType {
  final int _id;
  final String _name;
  final DocumentReference reference;

  int get id => this._id;
  String get name => this._name;

  MentoringType(this._id, this._name, {this.reference});

  MentoringType.fromMap(Map<String, dynamic> map, {this.reference})
    :assert(map['name'] != null),
    _id = 0,
    _name = map['name'];

  MentoringType.fromSnapshot(DocumentSnapshot snapshot):
    this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() {
    return "{'id':$_id, 'name':$_name}";
  }

  static getDocsOfDoc(doc) async {
    MentoringType type;
    await doc.data['mentoringType'].get().then((subDoc) => (
          type = MentoringType(
              subDoc.documentID == "VQiH1ylNHJ4roav0FAeE " ? 1 : 0,
              subDoc.data['name'])
    ));
    return type;

  }
  
}

class MentoringTypeList {
  static final List<MentoringType> _all = [
    MentoringType(0, 'Tutoría'),
    MentoringType(1, 'Solicitud de tutoría'),
  ];

  static MentoringType randGenerate() {
    Random randGen = new Random();
    return _all[randGen.nextInt(_all.length)];
  }
}
