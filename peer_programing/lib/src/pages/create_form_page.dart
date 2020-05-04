import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/mentoring_type_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/widgets/dropdown.dart';
import 'package:peer_programing/src/widgets/loading.dart';

class CreateForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CreateForm();
}

class _CreateForm extends State<CreateForm> with SingleTickerProviderStateMixin {
  final List<String> _mentoringTypesMap = ['learn', 'teach'];
  final _formKey = GlobalKey<FormState>();
  final Map<String, MentoringCategory> _categoriesMap = {};
  final SelectorTematicas _selectorTematicas = new SelectorTematicas(title:"Temática");
  List<MentoringCategory> _categories = [];
  Map<String,MentoringType> _mentoringTypes;
  TabController _formTabPageController;
  List<MentoringCategory> _selectedCategories = []; 
  String _name, _description, _lugar;
  int _tarifa;

  Function _requiredField({String subject = "Este campo"}) =>  (String value) => 
    value.isEmpty ? "$subject no puede estar vacío.": null;

  Widget _form() =>
    Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Título',
                hintStyle: TextStyle(
                  fontSize: 40
                ),
              ),
              style: TextStyle(
                fontSize: 40
              ),
              validator: this._requiredField(subject: "El tírulo"),
              onSaved: (String value) => this._name = value, 
            ),
            _selectorTematicas,
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Descripción',
              ),
              validator: this._requiredField(subject: "La Descrición"),
              onSaved: (String value) => this._description = value,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.monetization_on),
                hintText: 'Tarifa',
              ),
              validator: this._requiredField(subject: "La tarifa"),
              onSaved: (String value) => this._tarifa = int.parse(value)
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.place),
                hintText: 'Lugar',
              ),
              validator: this._requiredField(subject: "El lugar"),
              onSaved: (String value) => this._lugar = value
            ),
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    _formTabPageController =
        TabController(vsync: this, length: 2, initialIndex: 0);
  }

  MentoringType _selectedMentoringType() => this._mentoringTypes[_mentoringTypesMap[_formTabPageController.index]];

  Function _createMentoring(BuildContext context) => () async {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      final user = await UserModel.getOne();
      final Mentoring newMentoring = new Mentoring(
        name: this._name,
        description: this._description,
        precio: this._tarifa,
        lugar: this._lugar,
        mentoringTypeReference: _selectedMentoringType().reference,
        categoriesReference: _selectorTematicas.selectedCategories.map((MentoringCategory category) => category.reference).toList(),
        userReference: user.reference
      );

      await newMentoring.save();
      Navigator.pop(context);
    }
  };

  Widget _learn(Form form) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: form
    );
  }

  Widget _teach(Form form) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: form
    );
  }

  void _setMentoringTypes(AsyncSnapshot<QuerySnapshot> snapshot) => 
    this._mentoringTypes = MentoringType.mapMentoringTypes(MentoringType.listFromSnapshot(snapshot.data.documents));

  void _setCategories() =>
    MentoringCategory.all().then((List<MentoringCategory> categories) => setState((){this._categories = categories; this._categories.forEach((MentoringCategory category) => this._categoriesMap[category.reference.path] = category);}));

  @override
  Widget build(BuildContext context) =>
    StreamBuilder(
      stream: MentoringType.snapshot(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');        
        if ( snapshot.connectionState == ConnectionState.waiting)
          return Loading();

        if (this._mentoringTypes == null || this._mentoringTypes.isEmpty) _setMentoringTypes(snapshot);
        if (this._categories == null || this._categories.isEmpty) _setCategories();

        final Form creationForm = _form();

        return Scaffold(
          appBar: AppBar(
            title: Text('Crear publicación'),
            bottom: TabBar(
              controller: _formTabPageController,
              tabs: <Widget>[
                Tab(text: 'Para aprender'),
                Tab(text: 'Para enseñar'),
              ],
            ),
          ),
          body: TabBarView(
            controller: _formTabPageController,
            children: <Widget>[_learn(creationForm), _teach(creationForm)],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _createMentoring(context),
            child: Icon(Icons.save),
          ),
        );
      },
    );

}
