import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/widgets/loading.dart';
// import 'package:multiselect_formfield/multiselect_formfield.dart';

class SelectorTematicas extends StatefulWidget {
  final List _selectorTematicasStateWrapper = <_SelectorTematicasState>[null];
  final String _title;

  SelectorTematicas({String title}) : _title = title;

  List<MentoringCategory> get selectedCategories =>
      _selectorTematicasStateWrapper[0].selectedCategories;

  @override
  _SelectorTematicasState createState() => _selectorTematicasStateWrapper[0] =
      new _SelectorTematicasState(title: _title);
}

class _SelectorTematicasState extends State<SelectorTematicas> {
  Map<String, MentoringCategory> _categoryMap;
  List<MentoringCategory> _categories, _selectedCategories = [];
  List _myActivities = [];
  final String _title;

  List<MentoringCategory> get selectedCategories => _selectedCategories;

  _SelectorTematicasState({String title})
      : assert(title != null),
        _title = title;

  @override
  void initState() {
    super.initState();
  }

  Widget _multiselectCategorias() => Container(
        child: MultiSelectFormField(
          autovalidate: false,
          titleText: _title,
          validator: (_) {
            if (_selectedCategories == null || _selectedCategories.length == 0) {
              return 'Porfavor selecciona una o mas de una';
            }
            return null;
          },
          dataSource: _categories
              .map((category) =>
                  {"display": category.name, "value": category.reference.path})
              .toList(),
          textField: 'display',
          valueField: 'value',
          okButtonLabel: 'OK',
          cancelButtonLabel: 'CANCEL',
          required: true,
          hintText: 'Selecciona una o mas de una ',
          value: _myActivities,
          onSaved: (selectedCategories) {
            if (selectedCategories == null) return;
            setState(() {
              _selectedCategories = selectedCategories
                  .map<MentoringCategory>((path) => _categoryMap[path])
                  .toList();
              _myActivities = selectedCategories;
            });
          },
        ),
      );

  @override
  Widget build(BuildContext context) => StreamBuilder(
      stream: MentoringCategory.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        if (_categories == null || _categories.isEmpty) {
          _categoryMap = {};
          _categories =
              MentoringCategory.listFromSnapshot(snapshot.data.documents);
          _categories.forEach(
              (category) => _categoryMap[category.reference.path] = category);
        }

        return _multiselectCategorias();
      });
}
