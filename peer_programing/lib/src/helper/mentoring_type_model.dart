import 'dart:math';

class MentoringType {
  final int _id;
  final String _name;

  int get id => this._id;
  String get name => this._name;

  MentoringType(this._id, this._name);

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
