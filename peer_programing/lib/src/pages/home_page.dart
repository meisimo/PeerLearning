import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/theme.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/widgets/tarjetas/micro_card.dart';
import 'package:peer_programing/src/widgets/inputs/finder.dart';

class HomePage extends StatelessWidget {
  MentoringListView _mentoringListView = MentoringListView();
  final List<MentoringCategory> _categories = MentoringCategoryList.all();
  final _textInputStyle = TextStyle(
    color: Colors.white54,
    fontSize: 30,
    fontWeight: FontWeight.w500,
  );

  HomePage({Key key}) : super(key: key);

  Widget _finder() {
    return Finder(
      placeholder: "buscar...",
      onChange: (String input ){
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
              divider: SizedBox(
                width: 20,
              ),
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
              this._mentoringListView
            ],
          ),
        ));
  }
}
class MentoringListView extends StatefulWidget{
  final _MentoringListView _mentoringListView = _MentoringListView();

  @override
  StatefulElement createElement()=>
    super.createElement();

  @override
  _MentoringListView createState() =>
    _mentoringListView;

  void filerByTitle(String title)=>
    _mentoringListView.filter(title:title);

  void filterByCategory(List<int> categories) =>
    _mentoringListView.filter(category: categories);
}

class _MentoringListView extends State<MentoringListView>{
  String _titleFilter;
  List<int> _categoryFilter;
  List<Mentoring> _mentorings;
  double width;

  void filter({String title, List<int> category}){
    setState( () {
      if (title != null && title.length == 0) 
        this._titleFilter = null;
      else if (title != null)
        this._titleFilter = title.toUpperCase();

      if (category!=null && category.length == 0 ) 
        this._categoryFilter = null;
      else if (category != null)
       this._categoryFilter = category;
    });
  }
    

  List<Mentoring> _filterMentoringsByTitles(String title){
    return this._mentorings.where(
      (mentoring) => mentoring.name.toUpperCase().contains(title)
    ).toList();
  }

  List<Mentoring> _filterMentoringsByCategories(List<int> categories){
    return this._mentorings.where( 
      (Mentoring mentoring) => 
        0 < mentoring.categories.where( (category) => categories.contains(category.id)).length 
    ).toList();
  }

  List<Mentoring> _getMentoringListFiltered(){
    if (this._titleFilter != null && 3 < this._titleFilter.length)
      this._mentorings = _filterMentoringsByTitles(this._titleFilter);
    if (this._categoryFilter != null)
      this._mentorings = _filterMentoringsByCategories(this._categoryFilter);

    return this._mentorings;
  }

  Widget _mentoringList() {
    List<Widget> mentoringList = [];

    final Divider divider = Divider(
      thickness: 1,
      endIndent: 20,
      indent: 20,
    );

    for (Mentoring mentoring in this._getMentoringListFiltered()) {
      mentoringList.add(
        _mentoringResume(
            mentoring, _decorationContainerA(Colors.redAccent, -110, -85),
            background: LightColor.seeBlue),
      );
      mentoringList.add(divider);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: mentoringList),
      ),
    );
  }

  Widget _mentoringResume(Mentoring mentoring, Widget decoration,
      {Color background}) {
    return Container(
        height: 130,
        width: width,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: MicroCard(
                primary: background,
                backWidget: decoration,
                imgPath: mentoring.user.imgPath,
              ),
            ),
            Expanded(
                child: GestureDetector(
                    onTap: () => print("Tap"),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Expanded(
                                child: Text(mentoring.name,
                                    style: TextStyle(
                                        color: LightColor.purple,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ),
                              CircleAvatar(
                                radius: 3,
                                backgroundColor: background,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("${mentoring.points}",
                                  style: TextStyle(
                                    color: LightColor.grey,
                                    fontSize: 14,
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(_truncateDescription(mentoring.description),
                            style: AppTheme.h6Style.copyWith(
                                fontSize: 12,
                                color: LightColor.extraDarkPurple)),
                        SizedBox(height: 10),
                        Container(
                          width: width,
                          height: 21,
                          child: CategoryList(
                              divider: SizedBox(
                                width: 10,
                              ),
                              categories: mentoring.categories),
                        )
                      ],
                    )))
          ],
        ));
  }

  Widget _decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        _smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: _circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(
                radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(
            bottom: -35,
            right: -40,
            child:
                CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: _circularContainer(70, Colors.transparent,
              borderColor: Colors.white),
        ),
      ],
    );
  }

  Widget _decorationContainerC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  String _truncateDescription(String description) {
    final int maxLength = 90;
    return description.length > maxLength
        ? "${description.substring(0, maxLength)}..."
        : description;
  }

  Widget _circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }


  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  @override
  Widget build(BuildContext context){
    this.width = MediaQuery.of(context).size.width;
    this._mentorings = MentoringList.all();
    return this._mentoringList();
  }

}

class CategoryList extends StatelessWidget{
  final Widget divider;
  final List<MentoringCategory> categories;
  final Function onTap;

  CategoryList({this.divider,this.categories,this.onTap});

  @override
  Widget build(BuildContext context){
    List<Widget> categoryList = [];

    categories.forEach((category) {
      categoryList.add(divider);
      categoryList.add(TagChip(
        category.name,
        category.color,
        height: 5,
        id: category.id,
        onTap: this.onTap != null ? this.onTap(category): null,
      ));
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: categoryList,
    );
  }
}