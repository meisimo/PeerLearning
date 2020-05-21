import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/auth_module.dart';
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
import 'package:peer_programing/src/widgets/loading.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePage createState() => new _HomePage();
}

class _HomePage extends State<HomePage> {
  bool _loading = true, _logged = false;
  MentoringListView _mentoringListView, _requestListView;
  Map<String, MentoringType> _mentoringTypes;
  String _searchText, _title;
  List<MentoringCategory> _selectedCaterogies = [], _categories;
  PageController _pageController;
  final _textInputStyle = TextStyle(
    color: Colors.white54,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );
  static UserModel _user;

  String _selectedType() {
    if (_pageController.page ==0)
      return 'teach';
    else 
      return 'learn';
  }

  void _setTitle() => 
    setState(() =>
      _title = _selectedType() == 'teach'? 'Tutorías' : 'Solicitudes'
    );

  Function _showMentoringDetail(BuildContext context, Mentoring mentoring) =>
      () => showDialog(
          context: context,
          child: Detalle(mentoring,
              actionButton: new RaisedButton(
                child: Text('aceptar'),
                color: LightColor.purple,
                onPressed: _logged ? _selectMentoring(mentoring, context) : () => Navigator.pushNamed(context, '/login/action'),
              )));

  Function _selectMentoring(Mentoring mentoring, BuildContext context) => 
    ()=>
    mentoring
      .selectBy(_user)
      .then((_){
        _refreshMentorings();
        Navigator.pop(context);
      })
      .catchError((error) => print(error));

  void _refreshMentorings() =>
    Mentoring
      .getAvilables(_mentoringTypes[_selectedType()], _user)
      .then((List<Mentoring> mentorings) => 
        setState((){
          if(_selectedType() == 'teach')
            this._mentoringListView.refreshList(mentorings);
          else 
            this._requestListView.refreshList(mentorings);
        }
        )
      )
      .catchError( (error)=> print(error) );

  void _filterMentorings(){
    String selectedType = _selectedType();

    this._mentoringListView.filter(
      title: _searchText,
      categories: _selectedCaterogies,
      build: selectedType=='teach'
    );
    this._requestListView.filter(
      title: _searchText,
      categories: _selectedCaterogies,
      build: selectedType=='learn'
    );
  }

  Widget _finder() =>
    Finder(
      placeholder: "buscar...",
      onChange: (String input) {
        _searchText = input;
        _filterMentorings();
      },
      textStyle: this._textInputStyle,
    );

  Function _filterByCategories(MentoringCategory category) =>
    (){
      this._selectedCaterogies.add(category);
      _filterMentorings();
    };

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
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() { 
      if( _pageController.page.ceilToDouble() == _pageController.page)
        _setTitle();
      });
    _title = 'Tutorías';

    Future
      .wait( <Future>[MentoringType.all(), MentoringCategory.all(), UserModel.getCurrentUser()] )
      .then((result){
        setState(() {  
          _mentoringTypes = MentoringType.mapMentoringTypes(result[0]);
          _categories = result[1];
          _user = result[2];
          _mentoringListView = MentoringListView(
            onResumeTap: _showMentoringDetail,
            mentorigQuery: Mentoring.whereOfAvilable(_mentoringTypes['teach'], _user),
            filter: _filter(_mentoringTypes['teach'], _user),
          );
          _requestListView = MentoringListView(
            onResumeTap: _showMentoringDetail,
            mentorigQuery: Mentoring.whereOfAvilable(_mentoringTypes['learn'], _user),
            filter: _filter(_mentoringTypes['learn'], _user),
          );
          _logged = _user != null;
          _loading = false;
        });
      });
  }

  Widget _homeInfo(BuildContext context) => 
  Container(
    height: MediaQuery.of(context).size.height ,
    child: Column(
      children: <Widget>[
        _categoryRow(context, "Escoge una categoría"),
        Expanded( 
          child:PageView(
            controller: _pageController,
            children: <Widget>[
              this._mentoringListView,
              this._requestListView])
        ),
      ],
    )
  )
  ;
  
  @override
  Widget build(BuildContext context) {
    // (new Auth()).signOut();
    return MainLayout(
      title: _title,
      headerChild: this._finder(),
      body: (this._loading ? Loading() : _homeInfo(context)),
      floatingActionButton: _loading ? null : FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/create_mentoring'),
        child: Icon(Icons.add),
        backgroundColor: LightColor.orange,
      ),
    );
  }
}
