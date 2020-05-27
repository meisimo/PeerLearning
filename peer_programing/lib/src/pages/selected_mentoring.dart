import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/tarjetas/mentoring_feedback.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';

class SelectedMentorings extends StatefulWidget {
  @override
  _SelectedMentorings createState() => new _SelectedMentorings();
}

class _SelectedMentorings extends State<SelectedMentorings> {
  PageController _detailDialogPageController;
  bool _loading = true, _sendingFeedback=false, _logged=false;
  UserModel _user;
  MentoringListView _mentoringListView;
  bool _checkConnection = true;
  bool _connected = false;
  

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

    Widget _showPage() {
    return MainLayout(
      title: "Ofertas seleccionadas",
      body: this._loading ? _showLoading() : _logged ? _showMentorings() : _notLoggedMessage(),
      defaultVerticalScroll: false,
    );
  }

  Widget _cancelButton(Mentoring mentoring) => new RaisedButton(
                child: Text('Cancelar'),
                color: Colors.red,
                onPressed: ()=> handleConnectivity(onSuccess: (){
                 _unselectMentoring(mentoring, context);
                }, onError: () {
                  _showNotConnectedDialog(context);
                }
              ));

  Widget _doneButton(Mentoring mentoring) => new RaisedButton(
                child: Text('Realizada'),
                color: Colors.green,
                onPressed: ()=>_handleConnectivity(onSuccess:  _mentoringDone(mentoring, context)
                ,onError: (){
                   _showNotConnectedDialog(context);
                })
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
          mentoring.user.addMentoring();
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



  void _handleConnectivity({Function onSuccess, Function onError}) =>
      handleConnectivity(
          onSuccess: onSuccess,
          onError: onError,
          onResponse: () => this._checkConnection = false);

    void _showNotConnectedDialog(context) => showDialog(
      context: context,
      child: NotConnectedCard(tryToReconnect: () {
        Navigator.of(context).pop();
        setState(() {
          this._checkConnection = true;
        });
      }));


  Widget _showNotConnectedPage() {
    return MainLayout(
      title: "Ofertas seleccionadas",
      body: Padding(
        padding: EdgeInsets.all(100),
        child: Text(
          "No hay internet :(",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      defaultVerticalScroll: false,
    );
  }


  void _initCheckConnection(context) => _handleConnectivity(
      onError: () {
        _showNotConnectedDialog(context);
        setState(() => this._connected = false);
      },
      onSuccess: () => setState(() => this._connected = true));


       @override
  Widget build(BuildContext context) {
    if (_checkConnection) {
      _initCheckConnection(context);
    }

    if (this._connected) {
      return _showPage();
    } else {
      return _showNotConnectedPage();
    }
  }

}
