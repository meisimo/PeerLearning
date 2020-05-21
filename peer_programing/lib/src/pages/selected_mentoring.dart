import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/tarjetas/mentoring_feedback.dart';

class SelectedMentorings extends StatefulWidget {
  @override
  _SelectedMentorings createState() => new _SelectedMentorings();
}

class _SelectedMentorings extends State<SelectedMentorings> {
  PageController _detailDialogPageController;
  bool _loading = true, _sendingFeedback=false, _logged=false;
  UserModel _user;
  MentoringListView _mentoringListView;

  @override
  void initState(){
    _detailDialogPageController = PageController( initialPage: 0);
    Future
      .any(<Future>[UserModel.getCurrentUser()])
      .then((result){ 
        setState(() {
          _user = result;
          _logged = _user != null;
          _loading = false;
          if( _logged ){
            _mentoringListView = MentoringListView(
              onResumeTap: _showMentoringDetail,
              mentorigQuery: Mentoring.whereOfSelectedBy(_user),
            );
          }
        });
      });
  }

  Widget _notLoggedMessage() =>
    Text(
      "No se encuentra registrado. Por favor, ingrese con su usuario o registrese.",
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
      ),
      textAlign: TextAlign.center,
    );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Ofertas seleccionadas",
      body: this._loading ? _showLoading() : _logged ? _showMentorings() : _notLoggedMessage(),
      defaultVerticalScroll: false,
    );
  }

  Widget _cancelButton(Mentoring mentoring) => new RaisedButton(
                child: Text('Cancelar'),
                color: Colors.red,
                onPressed: _unselectMentoring(mentoring, context)
              );

  Widget _doneButton(Mentoring mentoring) => new RaisedButton(
                child: Text('Realizada'),
                color: Colors.green,
                onPressed: _mentoringDone(mentoring, context)
              );

  Widget _mentoringDetail(Mentoring mentoring) => Detalle(
    mentoring,
    actionButton: Container(
      child: Column(
        children: <Widget>[
          _doneButton(mentoring),
          _cancelButton(mentoring),
        ]
      ),
    )
  );

  Function _showMentoringDetail(BuildContext context, Mentoring mentoring) =>
      () => showDialog(
          context: context,
          child: PageView(
            physics:new NeverScrollableScrollPhysics(),
            controller: _detailDialogPageController,
            children: <Widget>[
              _mentoringDetail(mentoring),
              _sendingFeedback ? Loading() : MentoringFeedBack(mentoring: mentoring, onSave: _saveFeedBack,)
            ],
          ));

  void _saveFeedBack(Mentoring menoring, double calification, String comments){
    menoring
      .sendFeedBack(calification: calification, comments: comments)
      .then((_){
        _refreshMentorings();
        Navigator.pop(context);
        setState(() {
          _sendingFeedback = false;
        });
      });
    setState(() {
      _sendingFeedback = true;
    });
  }

  Function _unselectMentoring(Mentoring mentoring, BuildContext context) => 
    () =>
      mentoring
        .unselect()
        .then((_){
          _refreshMentorings();
          Navigator.pop(context);
        })
        .catchError( (error)=> print(error) );

  Function _mentoringDone(Mentoring mentoring, BuildContext context) => 
    () =>
      _detailDialogPageController.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeInOut);

  Widget _showLoading() => new CircularProgressIndicator();

  Widget _showMentorings() =>
    this._mentoringListView;

  void _refreshMentorings() =>
    Mentoring
      .filterBySelectedBy(_user)
      .then((List<Mentoring> mentorings) => 
        setState(()=>
          this._mentoringListView.refreshList(mentorings)
        )
      )
      .catchError( (error)=> print(error) );

}
