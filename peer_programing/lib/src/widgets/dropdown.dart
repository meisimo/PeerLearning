import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SelectorTematicas extends StatefulWidget {
  final List _selectorTematicasStateWrapper = <_SelectorTematicasState>[null];
  final String _title;
  final List<MentoringCategory> _selectedCategories;

  SelectorTematicas({String title, List<MentoringCategory> selectedCategories}) : _title = title, _selectedCategories = selectedCategories;

  List<MentoringCategory> get selectedCategories =>
      _selectorTematicasStateWrapper[0].selectedCategories;

  @override
  _SelectorTematicasState createState() => _selectorTematicasStateWrapper[0] =
      new _SelectorTematicasState(title: _title, selectedCategories: _selectedCategories);
}

class _SelectorTematicasState extends State<SelectorTematicas> {
  Map<String, MentoringCategory> _categoryMap;
  List<MentoringCategory> _categories, _selectedCategories;
  List _myActivities = [];
  List<int> _selectedItems = [];
  final String _title;
  List<MentoringCategory> get selectedCategories => _selectedCategories;
  
  _SelectorTematicasState({String title,List<MentoringCategory> selectedCategories})
      : assert(title != null),
        _title = title,
        _selectedCategories = selectedCategories != null ? selectedCategories: [];
  
  @override
  void initState() {
    super.initState();
  }

  void _mapSelectedCategories(){
    final nCategories = _categories.length;
    _selectedItems.clear();
    for (MentoringCategory selectedCategory in _selectedCategories) {
      for (int i = 0; i < nCategories; i++){
        if (_categories[i].reference.documentID == selectedCategory.reference.documentID){
          _selectedItems.add(i);
        }
      }
    }
  }

  Widget _multiselectCategorias() {
    _mapSelectedCategories();
    return SearchableDropdown.multiple(
        items: _categories
            .map((category) => DropdownMenuItem(
                  child: Text(category.name),
                  value: category.name,
                ))
            .toList(),
        displayClearIcon: false,
        selectedItems: _selectedItems,
        hint: "Temáticas",
        searchHint: "Temáticas",
        onChanged: (value) {
          setState(() {
            _selectedCategories = value
                .map<MentoringCategory>((indice) => _categories[indice])
                .toList();
            _selectedItems = value;
          });
        },
        doneButton: (selectedItemsDone, doneContext) {
          return new RaisedButton(
            onPressed: () => Navigator.of(doneContext).pop(),
            child: Text("Seleccionar"),
            color: LightColor.lightOrange,
          );
        },
        closeButton: null,
        isExpanded: true);
  }

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
