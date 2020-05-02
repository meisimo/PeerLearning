import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/mentoring_type_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';

import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/finder.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';

class HomePage extends StatelessWidget {
  final MentoringListView _mentoringListView;
  final List<MentoringCategory> _categories = MentoringCategoryList.all();
  final _textInputStyle = TextStyle(
    color: Colors.white54,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  HomePage({Key key}) : 
    _mentoringListView = MentoringListView(onResumeTap: _showMentoringDetail, mentoringSnapshot: Mentoring.snapshots()),
    super(key: key);

  static Function _showMentoringDetail(BuildContext context, int mentoringId) =>
      () => showDialog(
          context: context,
          child: Detalle(mentoringId,
              actionButton: new RaisedButton(
                child: Text('aceptar'),
                color: LightColor.purple,
                onPressed: () => print("Guardar esta oferta!"),
              )));

  Widget _finder() {
    return Finder(
      placeholder: "buscar...",
      onChange: (String input) {
        this._mentoringListView.filerByTitle(input);
      },
      textStyle: this._textInputStyle,
    );
  }

  Function filterByCategories(MentoringCategory category) {
    return () => this._mentoringListView.filterByCategory([category.id]);
  }

  Widget _categoryRow(BuildContext context, String title) {
    return Container(
      height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(
                  color: LightColor.extraDarkPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 30,
            child: CategoryList(
              dividerWidth: 20,
              categories: this._categories,
              onTap: filterByCategories,
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ofertas",
      headerChild: this._finder(),
      body: Container(
        child: Column(
          children: <Widget>[
            _categoryRow(context, "Escoge una categoría"),
            this._mentoringListView,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create_mentoring'),
        child: Icon(Icons.add),
        backgroundColor: LightColor.orange,
      ),
    );
  }
}
