import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/mentoring_type_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/widgets/dropdown.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';

class CreateForm extends StatefulWidget {
  final bool editMode;
  final Mentoring mentoringToEdit;
  final Function afterSave;

  CreateForm({this.editMode = false, this.mentoringToEdit, this.afterSave});

  @override
  State<StatefulWidget> createState() => _CreateForm(
      editMode: this.editMode, mentoringToEdit: this.mentoringToEdit, afterSave: this.afterSave);
}

class _CreateForm extends State<CreateForm>
    with SingleTickerProviderStateMixin {
  final bool editMode;
  final Mentoring mentoringToEdit;
  final List<String> _mentoringTypesMap = ['learn', 'teach'];
  final _formKey = GlobalKey<FormState>();
  final Map<String, MentoringCategory> _categoriesMap = {};
  final Function afterSave;


  int _initialPage = 0;
  SelectorTematicas _selectorTematicas;
  List<MentoringCategory> _categories = [];
  Map<String, MentoringType> _mentoringTypes;
  TabController _formTabPageController;
  List<MentoringCategory> _selectedCategories = [];
  String _name, _description, _lugar, _precio;
  int _tarifa;
  bool _checkConnection = true, _connected = false;

  _CreateForm({this.editMode = false, this.mentoringToEdit, this.afterSave}):super(){
    if (this.editMode){
      _selectorTematicas = new SelectorTematicas(title: "Temática", selectedCategories: mentoringToEdit.categories);
      _name = mentoringToEdit.name.toString();
      _description = mentoringToEdit.description.toString();
      _lugar = mentoringToEdit.lugar.toString();
      _precio = mentoringToEdit.precio.toString();
      
      if(mentoringToEdit.mentoringType.name == MentoringType.SOLICITUD){
        _initialPage = 0;
      } else {
        _initialPage = 1;
      }
    } else {
      _selectorTematicas = new SelectorTematicas(title: "Temática");
    }      
  }

  Function _requiredField({String subject = "Este campo"}) =>
      (String value) => value.isEmpty ? "$subject no puede estar vacío." : null;

  Function _requiredField2({String subject = "Este campo"}) => (String value) {
        if (value == "") {
          return value.isEmpty ? "$subject no puede estar vacío." : null;
        }
        try {
          if (int.parse(value) < 0) {
            return "El numero no puede ser negativo";
          }
        } catch (e) {
          return "Digite un numero valido porfavor";
        }
      };

  Widget _form() => Form(
        key: _formKey,
        autovalidate: true,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Título',
                hintStyle: TextStyle(fontSize: 40),
              ),
              style: TextStyle(fontSize: 40),
              validator: this._requiredField(subject: "El tírulo"),
              onSaved: (String value) => this._name = value,
              initialValue: _name,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.description),
                hintText: 'Descripción',
              ),
              validator: this._requiredField(subject: "La Descrición"),
              onSaved: (String value) => this._description = value,
              initialValue: _description,
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.monetization_on),
                hintText: 'Tarifa',
              ),
              validator: this._requiredField2(subject: "La tarifa"),
              onSaved: (String value) => this._tarifa = int.parse(value),
              keyboardType: TextInputType.number,
              initialValue: _precio,
            ),
            TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.place),
                  hintText: 'Lugar',
                ),
                validator: this._requiredField(subject: "El lugar"),
                onSaved: (String value) => this._lugar = value,
                initialValue: _lugar,
                ),
            _selectorTematicas,
          ],
        ),
      );

  @override
  void initState() {
    super.initState();
    _formTabPageController =
        TabController(vsync: this, length: 2, initialIndex: _initialPage);
  }

  MentoringType _selectedMentoringType() =>
      this._mentoringTypes[_mentoringTypesMap[_formTabPageController.index]];

  Function _createMentoring(BuildContext context) => () async {
        if (_formKey.currentState.validate()) {
          _formKey.currentState.save();
          final user = await UserModel.getCurrentUser();

          if (user == null) {
            Navigator.pushNamed(context, '/login/action');
            return;
          }

          final Mentoring newMentoring = new Mentoring(
              name: this._name,
              description: this._description,
              precio: this._tarifa,
              lugar: this._lugar,
              mentoringTypeReference: _selectedMentoringType().reference,
              categoriesReference: _selectorTematicas.selectedCategories
                  .map((MentoringCategory category) => category.reference)
                  .toList(),
              userReference: user.reference);

          await user.addMentoring();
          await newMentoring.save();
          Navigator.pop(context);
          if (afterSave != null)
            afterSave();
        }
      };

  Function _editMentoring(BuildContext context) => () async {
      if (_formKey.currentState.validate()) {
        _formKey.currentState.save();
        final user = await UserModel.getCurrentUser();

        if (user == null) {
          Navigator.pushNamed(context, '/login/action');
          return;
        }

        mentoringToEdit.name = this._name;
        mentoringToEdit.description = this._description;
        mentoringToEdit.precio = this._tarifa;
        mentoringToEdit.lugar = this._lugar;
        mentoringToEdit.mentoringTypeReference = _selectedMentoringType().reference;
        mentoringToEdit.mentoringType = _selectedMentoringType();
        mentoringToEdit.categories = _selectorTematicas.selectedCategories;
        mentoringToEdit.categoriesReference = _selectorTematicas.selectedCategories
                .map((MentoringCategory category) => category.reference)
                .toList();
        
        await mentoringToEdit.update();
        Navigator.pop(context);
        if (afterSave != null)
          afterSave();
      }
    };

  Widget _learn(Form form) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: form);
  }

  void _setMentoringTypes(AsyncSnapshot<QuerySnapshot> snapshot) =>
      this._mentoringTypes = MentoringType.mapMentoringTypes(
          MentoringType.listFromSnapshot(snapshot.data.documents));

  void _setCategories() => MentoringCategory.all()
      .then((List<MentoringCategory> categories) => setState(() {
            this._categories = categories;
            this._categories.forEach((MentoringCategory category) =>
                this._categoriesMap[category.reference.path] = category);
          }));

  Widget _showPage() => StreamBuilder(
        stream: MentoringType.snapshot(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return _showNotConnectedPage();
          if (snapshot.connectionState == ConnectionState.waiting)
            return _showLoadingPage();

          if (this._mentoringTypes == null || this._mentoringTypes.isEmpty)
            _setMentoringTypes(snapshot);
          if (this._categories == null || this._categories.isEmpty)
            _setCategories();

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
            body: SingleChildScrollView(
              child: _learn(creationForm),
            ),
            floatingActionButton: FloatingActionButton(
              heroTag: 'save-mentoring-btn',
              onPressed: () =>_handleConnectivity(
                onSuccess: this.editMode ?  _editMentoring(context): _createMentoring(context),
                onError: () {_showNotConnectedDialog(context); setState(() => this._connected = false);}
              ),
              child: Icon(Icons.save),
            ),
          );
        },
      );
  
  Widget _showNotConnectedPage() =>
    Scaffold(
            appBar: AppBar(
            title: Text('Crear publicación'),
            ),
            body: Padding(
        padding: EdgeInsets.all(100),
        child: Text(
          "No hay internet :(",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );

  Widget _showLoadingPage() =>
    Scaffold(
            appBar: AppBar(
            title: Text('Crear publicación'),
            ),
            body: Padding(
        padding: EdgeInsets.all(100),
        child: Loading(),
      ),
    );

  void _handleConnectivity({Function onSuccess, Function onError}) =>
      handleConnectivity(
          onSuccess: onSuccess,
          onError: onError,
          onResponse: () => this._checkConnection = false);

  void _showNotConnectedDialog(context) => showDialog(
      context: context,
      child: NotConnectedCard(tryToReconnect: () {
        Navigator.of(context).pop();
        setState(() {
          this._checkConnection = true;
        });
      }));

  void _initCheckConnection(context) => _handleConnectivity(
      onError: () {
        _showNotConnectedDialog(context);
        setState(() => this._connected = false);
      },
      onSuccess: () => setState(() => this._connected = true));

  @override
  Widget build(BuildContext context){
    if (_checkConnection) {
      _initCheckConnection(context);
    }
    if (this._connected) {
      return _showPage();
    } else {
      return _showNotConnectedPage();
    }
  }

}
