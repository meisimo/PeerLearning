import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/models/user.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator.dart';
import 'package:peer_programing/src/theme/theme.dart';
import 'package:peer_programing/src/widgets/tarjetas/micro_card.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';

class MentoringListView extends StatefulWidget {
  final _MentoringListView _mentoringListView;

  MentoringListView({
    Function onResumeTap,
    Stream<QuerySnapshot> mentoringSnapshot,
    filter({String title, List<MentoringCategory> categories})
  })
    : assert(mentoringSnapshot!=null),
      _mentoringListView = _MentoringListView(
        onResumeTap:onResumeTap,
        mentoringSnapshot:mentoringSnapshot,
        filter: filter
      );

  @override
  _MentoringListView createState() => _mentoringListView;

  void filter({String title, List<MentoringCategory> categories}) => 
    _mentoringListView.filter(title: title, categories: categories);

}

class _MentoringListView extends State<MentoringListView> {
  List<Mentoring> _mentorings;
  double width;
  bool _searching = false;
  final Function onResumeTap;
  final Stream<QuerySnapshot> mentoringSnapshot;
  final Function _filter;

  _MentoringListView({
    this.onResumeTap,
    this.mentoringSnapshot,
    Future<List<dynamic>> filter({String title, List<MentoringCategory> categories})
  }): _mentorings = null,
      _filter = filter, 
      super();

  void filter({String title = '', List<MentoringCategory> categories = const []}) {
    setState(() {
      _searching = true;
    });
    _filter(
      title: ( title==null || title.length < 3) ? null: title,
      categories: (categories == null || categories.isEmpty ? null : categories)
    ).then((List<Mentoring> mentorings){
      setState(() {
        this._mentorings = mentorings;
        _searching = false;
      });
    });
  }

  // List<Mentoring> _filterMentoringsByTitles(String title) {
  //   return this
  //       ._mentorings
  //       .where((mentoring) => mentoring.name.toUpperCase().contains(title))
  //       .toList();
  // }



  List<Mentoring> _filterMentoringsByCategories(List<int> categories) {
    return this
        ._mentorings
        .where((Mentoring mentoring) =>
            0 <
            mentoring.categories
                .where((category) => categories.contains(category.id))
                .length)
        .toList();
  }

  Widget _mentoringList(BuildContext context){
    List<Widget> mentoringList = [];

    final Divider divider = Divider(
      thickness: 1,
      endIndent: 20,
      indent: 20,
    );

    for (Mentoring mentoring in this._mentorings) {
      mentoringList.add(
        _mentoringResume(context, mentoring,
            Decorator.generateDecoration(),
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

  Widget _mentoringResume(
      BuildContext context, Mentoring mentoring, Widget decoration,
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
                    onTap: onResumeTap != null
                        ? this.onResumeTap(context, mentoring)
                        : null,
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
                              dividerWidth: 10,
                              categories: mentoring.categories),
                        )
                      ],
                    )))
          ],
        ));
  }

  String _truncateDescription(String description) {
    final int maxLength = 90;
    return description.length > maxLength
        ? "${description.substring(0, maxLength)}..."
        : description;
  }

  Future<void> _initialGetMentorings(AsyncSnapshot<QuerySnapshot> snapshot) => 
    Future.wait(Mentoring.listFromSnapshot(snapshot.data.documents)).then( (mentorings) => setState(() => this._mentorings = mentorings.map((m) => cast<Mentoring>(m)).toList()));

  @override
  Widget build(BuildContext context) => 
    StreamBuilder<QuerySnapshot>(
      stream: mentoringSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        if ( snapshot.connectionState == ConnectionState.waiting || _searching )
          return CircularProgressIndicator();
        if (this._mentorings == null){
          _initialGetMentorings(snapshot);
          return CircularProgressIndicator();
        }

        return this._mentoringList(context);
      },
    );
}
