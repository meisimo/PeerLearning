import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator.dart';
import 'package:peer_programing/src/theme/theme.dart';
import 'package:peer_programing/src/widgets/tarjetas/micro_card.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';

class MentoringListView extends StatefulWidget {
  final _MentoringListView _mentoringListView;

  MentoringListView({Function onResumeTap,Stream<QuerySnapshot> mentoringSnapshot})
    : assert(mentoringSnapshot!=null),
      _mentoringListView = _MentoringListView(onResumeTap:onResumeTap, mentoringSnapshot:mentoringSnapshot);

  @override
  _MentoringListView createState() => _mentoringListView;

  void filerByTitle(String title) => _mentoringListView.filter(title: title);

  void filterByCategory(List<int> categories) =>
      _mentoringListView.filter(category: categories);
}

class _MentoringListView extends State<MentoringListView> {
  String _titleFilter;
  List<int> _categoryFilter;
  List<Mentoring> _mentorings;
  double width;
  final Function onResumeTap;
  final Stream<QuerySnapshot> mentoringSnapshot;

  _MentoringListView({this.onResumeTap, this.mentoringSnapshot}) : _mentorings = [], super();

  void filter({String title, List<int> category}) {
    setState(() {
      if (title != null && title.length == 0)
        this._titleFilter = null;
      else if (title != null) this._titleFilter = title.toUpperCase();

      if (category != null && category.length == 0)
        this._categoryFilter = null;
      else if (category != null) this._categoryFilter = category;
    });
  }

  List<Mentoring> _filterMentoringsByTitles(String title) {
    return this
        ._mentorings
        .where((mentoring) => mentoring.name.toUpperCase().contains(title))
        .toList();
  }

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

  List<Mentoring> _getMentoringListFiltered() {
    if (this._titleFilter != null && 3 < this._titleFilter.length)
      this._mentorings = _filterMentoringsByTitles(this._titleFilter);
    if (this._categoryFilter != null)
      this._mentorings = _filterMentoringsByCategories(this._categoryFilter);

    return this._mentorings;
  }

  Widget _mentoringList(BuildContext context) {
    List<Widget> mentoringList = [];

    final Divider divider = Divider(
      thickness: 1,
      endIndent: 20,
      indent: 20,
    );

    for (Mentoring mentoring in this._getMentoringListFiltered()) {
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
                        ? this.onResumeTap(context, mentoring.id)
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

  @override
  Widget build(BuildContext context) => 
    StreamBuilder<QuerySnapshot>(
      stream: mentoringSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');        
        if ( snapshot.connectionState == ConnectionState.waiting)
          return new Text('Loading...');
        if (this._mentorings.isEmpty)
          Future.wait(Mentoring.listFromSnapshot(snapshot.data.documents)).then( (mentorings) => setState(() => this._mentorings = mentorings.map((m) => cast<Mentoring>(m)).toList()));
        return this._mentoringList(context);
      },
    );
}
