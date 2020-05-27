import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/create_form_page.dart';
import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';
import 'package:peer_programing/src/pages/tutor_profile_page.dart';

class OwnMentorings extends StatefulWidget {
  @override
  _SelectedMentorings createState() => new _SelectedMentorings();
}

class _SelectedMentorings extends State<OwnMentorings> {
  PageController _detailDialogPageController;
  bool _loading = true, _logged = false;
  UserModel _user;
  MentoringListView _mentoringListView;
  bool _checkConnection = true, _connected = false;

  _SelectedMentorings();

  @override
  void initState() {
    super.initState();
    _detailDialogPageController = PageController(initialPage: 0);
    Future.any(<Future>[UserModel.getCurrentUser()]).then((result) {
      setState(() {
        _user = result;
        _logged = _user != null;
        _loading = false;
        if (_logged) {
          _mentoringListView = MentoringListView(
            onResumeTap: _showMentoringDetail,
            mentorigQuery: Mentoring.whereOfCreatedBy(_user),
          );
        }
      });
    });
  }

  Widget _notLoggedMessage() => Text(
        "No se encuentra registrado. Por favor, ingrese con su usuario o registrese.",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

  void _afterEdit() {
    Navigator.of(context).pop();
    _refreshMentorings();
  }

  Function _disableMentoring(Mentoring mentoring, BuildContext context) => () {
        mentoring.disable().then((_) {
          _refreshMentorings();
          mentoring.user.removeMentoring();
          Navigator.pop(context);
        }).catchError((error) {
          Navigator.pop(context);
          print(error);
        });
      };

  Function _unselectMentoring(Mentoring mentoring, BuildContext context) => () {
        mentoring.unselect().then((_) {
          _refreshMentorings();
          Navigator.pop(context);
        }).catchError((error) {
          Navigator.pop(context);
          print(error);
        });
      };

  Function _successfullMentoring(Mentoring mentoring, BuildContext context) => () {
        mentoring.markAsSuccessful().then((_) {
          _refreshMentorings();
          Navigator.pop(context);
        }).catchError((error) {
          Navigator.pop(context);
          print(error);
        });
      };

  Function _goToEdit(Mentoring mentoring, BuildContext context) =>
      () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => new CreateForm(
                editMode: true,
                mentoringToEdit: mentoring,
                afterSave: _afterEdit,
              )));

  Widget _cancelMentoring(Mentoring mentoring) => new RaisedButton(
        child: Text('Cancelar'),
        color: Colors.red,
        onPressed: () => _handleConnectivity(
            onSuccess: _disableMentoring(mentoring, context),
            onError: () {
              Navigator.of(context).pop();
              _showNotConnectedDialog(context);
            }),
      );

  Widget _editMentoring(Mentoring mentoring) => new RaisedButton(
      child: Text('Editar'),
      color: LightColor.purple,
      onPressed: _goToEdit(mentoring, context));

  Widget _rejectMentoring(Mentoring mentoring) => new RaisedButton(
        child: Text('Rechazar'),
        color: Colors.red,
        onPressed: () => _handleConnectivity(
            onSuccess: _unselectMentoring(mentoring, context),
            onError: () {
              Navigator.of(context).pop();
              _showNotConnectedDialog(context);
            }),
      );

  Widget _markSuccessfullMentoring(Mentoring mentoring) => new RaisedButton(
      child: Text('Realizada'),
      color: Colors.green,
      onPressed:() =>  _handleConnectivity(
            onSuccess: _successfullMentoring(mentoring, context),
            onError: () {
              Navigator.of(context).pop();
              _showNotConnectedDialog(context);
            }));

  List<Widget> _freeMentoringButonSet(mentoring) => <Widget>[
        _editMentoring(mentoring),
        _cancelMentoring(mentoring),
      ];

  List<Widget> _selectedMentoringButonSet(mentoring) => <Widget>[
        _markSuccessfullMentoring(mentoring),
        _rejectMentoring(mentoring),
      ];

  Widget _mentoringDetail(Mentoring mentoring) {
    return Detalle(
      mentoring,
      mentoring.selectedBy == null ? mentoring.user : mentoring.selectedBy,
        actionButton: Container(
          child: Column(
              children: mentoring.selectedByReference == null
                  ? _freeMentoringButonSet(mentoring)
                  : _selectedMentoringButonSet(mentoring)),
        ),
      onUserTap: mentoring.selectedBy == null ? null : (() => Navigator.push(context, new MaterialPageRoute(builder: (context) => new TutorProfilePage(tutor: mentoring.selectedBy)))),
    );
  }

  Function _showMentoringDetail(BuildContext context, Mentoring mentoring) =>
      () => showDialog(context: context, child: _mentoringDetail(mentoring));

  Widget _showLoading() => new CircularProgressIndicator();

  Widget _showMentorings() => this._mentoringListView;

  void _handleConnectivity({Function onSuccess, Function onError}) =>
      handleConnectivity(
          onSuccess: onSuccess,
          onError: onError,
          onResponse: () => this._checkConnection = false);

  void _refreshMentorings() => Mentoring.filterByCreatedBy(_user)
      .then((List<Mentoring> mentorings) =>
          setState(() => this._mentoringListView.refreshList(mentorings)))
      .catchError((error) => print(error));

  void _showNotConnectedDialog(context) => showDialog(
      context: context,
      child: NotConnectedCard(tryToReconnect: () {
        Navigator.of(context).pop();
        setState(() {
          this._checkConnection = true;
        });
      }));

  Widget _showNotConnectedPage() => MainLayout(
        title: "Tus ofertas activas",
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
        withBottomNavBar: false,
        goBack: true,
      );

  Widget _showPage() => MainLayout(
        title: "Tus ofertas activas",
        body: this._loading
            ? _showLoading()
            : _logged ? _showMentorings() : _notLoggedMessage(),
        defaultVerticalScroll: false,
        withBottomNavBar: false,
        goBack: true,
      );

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
