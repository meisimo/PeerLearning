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

class HomePage extends StatefulWidget {

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  MentoringListView _mentoringListView;
  Map<String, MentoringType> _mentoringTypes;
  bool _loading = true;
  String _searchText;
  List<MentoringCategory> _selectedCaterogies = [];
  List<MentoringCategory> _categories;
  final _textInputStyle = TextStyle(
    color: Colors.white54,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );
  static UserModel _user;

  _HomePage(){
    UserModel.getOne().then((user) => _user = user);
  }
  
  static Function _showMentoringDetail(BuildContext context, Mentoring mentoring) =>
      () => showDialog(
          context: context,
          child: Detalle(mentoring,
              actionButton: new RaisedButton(
                child: Text('aceptar'),
                color: LightColor.purple,
                onPressed: _selectMentoring(mentoring, context),
              )));

  static Function _selectMentoring(Mentoring mentoring, BuildContext context) => () async {
    await mentoring.selectBy(_user);
    Navigator.pop(context);
  };

  void _filterMentorings() =>
    this._mentoringListView.filter(title: _searchText, categories: _selectedCaterogies);

  Widget _finder() {
    return Finder(
      placeholder: "buscar...",
      onChange: (String input) {
        _searchText = input;
        _filterMentorings();
      },
      textStyle: this._textInputStyle,
    );
  }

  Function _filterByCategories(MentoringCategory category) {
    return (){
      this._selectedCaterogies.add(category);
      _filterMentorings();
    };
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
              onTap: _filterByCategories,
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Function _filter(MentoringType mentoringType, UserModel user) => 
    ({String title, List<MentoringCategory> categories}) async{
      if(title != null && categories != null)
        return await Mentoring.filterByTitleAndCategory(mentoringType, user, title: title, categories: categories);
      else if (title != null)
        return await Mentoring.filterByTitle(mentoringType, user, title);
      else if (categories != null)
        return await Mentoring.filterByCategory(mentoringType, user, categories);
      else 
        return await Mentoring.getAvilables(mentoringType, user);
    };
  
  @override
  void initState() {
    _loading = true;
    Future
      .wait( <Future>[MentoringType.all(), MentoringCategory.all()] )
      .then((result){
        setState(() {  
          _mentoringTypes = MentoringType.mapMentoringTypes(result[0]);
          _categories = result[1];
          _mentoringListView = MentoringListView(
            onResumeTap: _showMentoringDetail,
            mentoringSnapshot: Stream.fromFuture(Mentoring.whereOfAvilable(_mentoringTypes['teach'], _user)),
            filter: _filter(_mentoringTypes['teach'], _user),
          );
          _loading = false;  
        });
      });
  }

  Widget _loadingView() => Text("Loaging");

  Widget _homeInfo() => 
   Container(
        child: Column(
          children: <Widget>[
            _categoryRow(context, "Escoge una categoría"),
            this._mentoringListView,
          ],
        ),
      );
  
  @override
  Widget build(BuildContext context) {
    // if (!_loading)
    //   Mentoring.filterByTitle(_mentoringTypes['teach'], _user, 'Test').then((r) => print(r));
    return MainLayout(
      title: "Ofertas",
      headerChild: this._finder(),
      body: (this._loading ? _loadingView(): _homeInfo()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create_mentoring'),
        child: Icon(Icons.add),
        backgroundColor: LightColor.orange,
      ),
    );
  }
}
