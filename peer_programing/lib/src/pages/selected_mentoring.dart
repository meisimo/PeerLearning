import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';

class SelectedMentorings extends StatefulWidget {
  @override
  _SelectedMentorings createState() => new _SelectedMentorings();
}

class _SelectedMentorings extends State<SelectedMentorings> {
  bool _loading = true;
  UserModel _user;
  MentoringListView _mentoringListView;
      
  Function _showMentoringDetail(BuildContext context, Mentoring mentoring) =>
      () => showDialog(
          context: context,
          child: Detalle(mentoring,
              actionButton: new RaisedButton(
                child: Text('Cancelar'),
                color: Colors.red,
                onPressed: _unselectMentoring(mentoring, context)
              )));

  Function _unselectMentoring(Mentoring mentoring, BuildContext context) => 
    () =>
      mentoring
        .unselect()
        .then((_){
          _refreshMentorings();
          Navigator.pop(context);
        })
        .catchError( (error)=> print(error) );

  Widget _showLoading() => new CircularProgressIndicator();

  Widget _showMentorings() =>
    Container(
        child: Column(
          children: <Widget>[
            this._mentoringListView,
          ],
        ),
      );

  void _refreshMentorings() =>
    Mentoring
      .filterBySelectedBy(_user)
      .then((List<Mentoring> mentorings) => 
        setState(()=>
          this._mentoringListView.refreshList(mentorings)
        )
      )
      .catchError( (error)=> print(error) );

  @override
  void initState(){
    Future
      .any(<Future>[UserModel.getOne()])
      .then((result){ 
        setState(() {
          _user = result;
          _mentoringListView = MentoringListView(
            onResumeTap: _showMentoringDetail,
            mentoringSnapshot: Stream.fromFuture(Mentoring.whereOfSelectedBy(_user)),
          );
          _loading = false;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ofertas seleccionadas",
      body: this._loading ? _showLoading() : _showMentorings()
    );
  }
}
