import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/theme/decorator_containers/decorator.dart';
import 'package:peer_programing/src/theme/theme.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/tarjetas/micro_card.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';

class MentoringListView extends StatefulWidget {
  final Function _onResumeTap;
  final Future<QuerySnapshot> _mentorigQuery;
  final Function _filter;
  final List _entoringListViewWrapper = <_MentoringListView>[null];
  final Map<String, dynamic> _filters = {};

  bool get hasFilters =>
      (_filters['title'] != null && _filters['title'].isEmpty) ||
      (_filters['categories'] != null && _filters['categories'].isEmpty);
  get _mentoringListView => _entoringListViewWrapper[0];

  MentoringListView(
      {Function onResumeTap,
      Future<QuerySnapshot> mentorigQuery,
      Function filter})
      : _filter = filter,
        _mentorigQuery = mentorigQuery,
        _onResumeTap = onResumeTap;

  @override
  _MentoringListView createState() =>
      _entoringListViewWrapper[0] = new _MentoringListView(
          filter: _filter,
          mentoringSnapshot: Stream.fromFuture(_mentorigQuery),
          onResumeTap: _onResumeTap,
          filters: _filters);

  void refreshList(List<Mentoring> mentorings) =>
      _entoringListViewWrapper[0].refreshList(mentorings);

  void filter(
      {String title, List<MentoringCategory> categories, bool build = false}) {
    _filters['title'] = title;
    _filters['categories'] = categories;
    _entoringListViewWrapper[0]
        .filter(title: title, categories: categories, build: build);
  }
}

class _MentoringListView extends State<MentoringListView> {
  List<Mentoring> _mentorings;
  double width;
  bool _searching = false;
  final Function onResumeTap;
  final Stream<QuerySnapshot> mentoringSnapshot;
  final Function _filter;
  Map<String, dynamic> _filters = {};

  bool get hasFilters =>
      _filters != null &&
      ((_filters['title'] != null && _filters['title'].isEmpty) ||
          (_filters['categories'] != null && _filters['categories'].isEmpty));

  _MentoringListView(
      {this.onResumeTap,
      this.mentoringSnapshot,
      Future<List<dynamic>> filter(
          {String title, List<MentoringCategory> categories}),
      Map<String, dynamic> filters})
      : _mentorings = null,
        _filter = filter,
        _filters = filters,
        super();

  void filter(
      {String title = '',
      List<MentoringCategory> categories = const [],
      bool build = true}) {
    _filters['title'] = title;
    _filters['categories'] = categories;
    if (build) {
      setState(() {
        _searching = true;
      });
      _filter(
              title: (title == null || title.length < 3) ? null : title,
              categories: (categories == null || categories.isEmpty
                  ? null
                  : categories))
          .then((List<Mentoring> mentorings) {
        setState(() {
          this._mentorings = mentorings;
          _searching = false;
        });
      });
    }
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

  Widget _notMentoringToShow() => Padding(
        padding: EdgeInsets.all(100),
        child: Text(
          "No se há conseguido ninguna coincidencia.",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );

  Widget _mentoringList(BuildContext context) {
    List<Widget> mentoringList = [];

    final Divider divider = Divider(
      thickness: 1,
      endIndent: 20,
      indent: 20,
    );

    for (Mentoring mentoring in this._mentorings) {
      mentoringList.add(
        _mentoringResume(context, mentoring, Decorator.generateDecoration(),
            background: LightColor.seeBlue),
      );
      mentoringList.add(divider);
    }

    return ListView(
      scrollDirection: Axis.vertical,
      children: mentoringList,
    );
  }

  Widget _mentoringPoints(double points, Color background) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 3,
            backgroundColor: background,
          ),
          SizedBox(
            width: 5,
          ),
          Text("$points",
              style: TextStyle(
                color: LightColor.grey,
                fontSize: 14,
              ))
        ],
      ));

  Widget _newUserPointsMark() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text("Nuevo",
          style: TextStyle(
            color: LightColor.grey,
            fontSize: 14,
          )));

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
                              (mentoring.points < 0.5
                                  ? _newUserPointsMark()
                                  : _mentoringPoints(
                                      mentoring.points, background)),
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
      Future.wait(Mentoring.listFromSnapshot(snapshot.data.documents)).then(
          (mentorings) => setState(() => this._mentorings =
              mentorings.map((m) => cast<Mentoring>(m)).toList()));

  void refreshList(List<Mentoring> mentorings) => setState(() {
        this._mentorings = mentorings;
      });

  @override
  Widget build(BuildContext context) => StreamBuilder<QuerySnapshot>(
        stream: mentoringSnapshot,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting || _searching)
            return Loading();
          if (this._mentorings == null) {
            if (hasFilters)
              _initialGetMentorings(snapshot).then((_) => filter(
                  title: _filters['title'],
                  categories: _filters['categories']));
            else
              _initialGetMentorings(snapshot);
            return Loading();
          }
          return this._mentorings.isEmpty
              ? _notMentoringToShow()
              : this._mentoringList(context);
        },
      );
}
