
import 'dart:math';

class MentoringType{
  final int _id;
  final String _name;

  int get id => this._id;
  String get name => this._name;

  MentoringType(this._id, this._name);

  @override
  String toString(){
    return "{'id':$_id, 'name':$_name}";
  }
}

class MentoringTypeList{
  static final List<MentoringType> _all = [
    MentoringType(0,'Tutoría'),
    MentoringType(1,'Solicitud de tutoría'),
  ];

  static MentoringType randGenerate(){
    Random randGen = new Random();
    return _all[randGen.nextInt(_all.length)];
  }
}