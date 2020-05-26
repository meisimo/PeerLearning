import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/mentoring_model.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/create_form_page.dart';
import 'package:peer_programing/src/pages/detalle.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/widgets/inputs/tag_chip.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/mentoring_listview.dart';

class OwnMentorings extends StatefulWidget {
  @override
  _SelectedMentorings createState() => new _SelectedMentorings();
}

class _SelectedMentorings extends State<OwnMentorings> {
  PageController _detailDialogPageController;
  bool _loading = true, _logged = false;
  UserModel _user;
  MentoringListView _mentoringListView;

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

  Widget _cancelMentoring(Mentoring mentoring) => new RaisedButton(
      child: Text('Cancelar'),
      color: Colors.red,
      onPressed: _disableMentoring(mentoring, context));

  Widget _editMentoring(Mentoring mentoring) => new RaisedButton(
      child: Text('Editar'),
      color: LightColor.purple,
      onPressed: _goToEdit(mentoring, context));

  Widget _mentoringDetail(Mentoring mentoring) {
    return Detalle(mentoring,
        actionButton: Container(
          child: mentoring.selectedByReference == null
              ? Column(children: <Widget>[
                  _editMentoring(mentoring),
                  _cancelMentoring(mentoring),
                ])
              : TagChip("No editable", LightColor.grey, height: 30),
        ));
  }

  Function _showMentoringDetail(BuildContext context, Mentoring mentoring) =>
      () => showDialog(context: context, child: _mentoringDetail(mentoring));

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

  void _afterEdit(){
    Navigator.of(context).pop();
    _refreshMentorings();
  }

  Function _goToEdit(Mentoring mentoring, BuildContext context) =>
      () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => new CreateForm(
                editMode: true,
                mentoringToEdit: mentoring,
                afterSave: _afterEdit,
              )));

  Widget _showLoading() => new CircularProgressIndicator();

  Widget _showMentorings() => this._mentoringListView;

  void _refreshMentorings() => Mentoring.filterByCreatedBy(_user)
      .then((List<Mentoring> mentorings) =>
          setState(() => this._mentoringListView.refreshList(mentorings)))
      .catchError((error) => print(error));

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: "Tus ofertas activas",
      body: this._loading
          ? _showLoading()
          : _logged ? _showMentorings() : _notLoggedMessage(),
      defaultVerticalScroll: false,
      withBottomNavBar: false,
      goBack: true,
    );
  }
}
