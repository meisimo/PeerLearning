import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/quad_clipper.dart';
import 'package:peer_programing/src/theme/theme.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';

class HomePage extends StatelessWidget {
  List<MentoringCategory> _categories;
  List<Mentoring> _mentorings;
  double width;

  HomePage({Key key}) : super(key: key) {
    this._categories = MentoringCategoryList.all();
    this._mentorings = MentoringList.all();
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

  Widget _finder(){
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "buscar...",
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              )
            ],
          ),
        ],
      ),
    );
  }

  ListView _categoryList({Widget divider, List<MentoringCategory> categories}){
    List<Widget> categoryList = [];

    categories.forEach((category){
      categoryList.add(divider);
      categoryList.add(
        TagChip(
          category.name,
          category.color,
          height: 5,
          id: category.id,
        )
      );  
    });

    return ListView(
      scrollDirection: Axis.horizontal,
      children: categoryList,
    );
  }

  Widget _categoryRow(String title) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
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
          SizedBox(height: 10,),
          Container(
            width: width,
            height: 30,
            child: _categoryList(
              divider: SizedBox(width: 20,),
              categories: this._categories,
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _mentoringList() {
    /*
    List<Widget> mentoringList = <Widget>[
      _courceInfo(this._mentorings[0],
          _decorationContainerA(Colors.redAccent, -110, -85),
          background: LightColor.seeBlue),
      Divider(
        thickness: 1,
        endIndent: 20,
        indent: 20,
      ),
      _courceInfo(CourseList.list[1], _decorationContainerB(),
          background: LightColor.darkOrange),
      Divider(
        thickness: 1,
        endIndent: 20,
        indent: 20,
      ),
      _courceInfo(CourseList.list[2], _decorationContainerC(),
          background: LightColor.lightOrange2), 
    ];
    */
    List<Widget> mentoringList = [];
    
    final Divider divider = Divider(
      thickness: 1,
      endIndent: 20,
      indent: 20,
    );

    for(Mentoring mentoring in this._mentorings){
      mentoringList.add(
        _mentoringResume(
          mentoring,
          _decorationContainerA(Colors.redAccent, -110, -85),
          background: LightColor.seeBlue
        ),
      );
      mentoringList.add(divider);
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: mentoringList
        ),
      ),
    );
  }

  Widget _card({
    Color primaryColor = Colors.redAccent,
    String imgPath,
    Widget backWidget
  }) {
    return Container(
        height: 190,
        width: width * .34,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  color: Color(0x12000000))
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          child: backWidget,
        ));
  }

  Widget _mentoringResume(Mentoring mentoring, Widget decoration, {Color background}) {
    return Container(
        height: 170,
        width: width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(primaryColor: background, backWidget: decoration),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => print("Tap"),
                child:Column(
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
                        )
                      ),
                      SizedBox(width: 10)
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Text(mentoring.description,
                    style: AppTheme.h6Style.copyWith(
                        fontSize: 12, color: LightColor.extraDarkPurple)),
                SizedBox(height: 15),
                  Container(
                    width: width,
                    height: 30,
                    child: _categoryList(
                      divider: SizedBox(width: 10,),
                      categories: mentoring.categories
                  ),
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
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return MainLayout(
      title: "Ofertas",
      headerChild: this._finder(),
      body: Container(
        child: Column(
          children: <Widget>[
            _categoryRow("Escoge una categoría"),
            _mentoringList()
          ],
        ),
      )
    );
  }
}
