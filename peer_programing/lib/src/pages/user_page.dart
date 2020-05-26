import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/pages/own_mentorings.dart';
import 'package:peer_programing/src/theme/color/light_color.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/utils/dev.dart';
import 'package:peer_programing/src/widgets/dropdown.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/lists/category_list.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/points/points_resume.dart';
import 'package:peer_programing/src/widgets/stars_points.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';

const int NAME_MAX_LENGTH = 200;
const int EMAIL_MAX_LENGTH = 200;

class UserPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return UserPageState();
  }
}

class UserPageState extends State<StatefulWidget> {
  final int COMENT_MAX_LENGTH = 50;
  final _keyForm = GlobalKey<FormState>();
  bool _checkConnection = true;
  bool _connected = false;

  SelectorTematicas _selectorTematicas;
  UserModel _usuarioR;
  bool _loading = true;
  bool _editMode = false;
  TextEditingController _nameField = TextEditingController();

  @override
  void initState() {
    super.initState();
    UserModel.getCurrentUser()
        .then((usuario) => usuario.populate().then((usuario) {
              _selectorTematicas = new SelectorTematicas(
                  title: "Temática de interes",
                  selectedCategories: usuario.categories);
              _nameField.text = usuario.name;
              setState(() {
                this._usuarioR = usuario;
                _loading = false;
              });
            }));
  }

  Widget _paginaUsuario() => Container(
      constraints: new BoxConstraints(
        minHeight: 500,
        maxHeight: 800,
      ),
      child: Column(
        children: <Widget>[
          //Image of profile
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImagenPerfil(
                user: _usuarioR,
              )
            ],
          ),

          SizedBox(
            height: 20.0,
          ),
          //Puntuacion tutoria, estudiante
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // estrellaPuntuacion(_usuarioR.points.toString())
                  StartsPoints(5, _usuarioR.points)
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ContenedorEdit(
                    user: _usuarioR,
                  )
                ],
              )
            ],
          ),
          _userCategories(),
          Flexible(
            fit: FlexFit.loose,
            child: _feedBackList(),
          ),
          _signOutButton()
        ],
      ));

  Widget _formEdicionUsuario() => Container(
      constraints: new BoxConstraints(
        minHeight: 500,
        maxHeight: 800,
      ),
      child: Column(
        children: <Widget>[
          //Image of profile
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImagenPerfil(
                user: _usuarioR,
              )
            ],
          ),

          SizedBox(
            height: 20.0,
          ),
          //Puntuacion tutoria, estudiante
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // estrellaPuntuacion(_usuarioR.points.toString())
                  StartsPoints(5, _usuarioR.points)
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[_editForm()],
              )
            ],
          ),
        ],
      ));

  Widget _editForm() => Form(
      key: _keyForm,
      child: Container(
        width: 310.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            InputLogin(
              Key('input-nombre'),
              Icon(
                Icons.person,
                color: Colors.white,
              ),
              "Nombre",
              pasword: false,
              requiredField: true,
              controller: _nameField,
              inputType: TextInputType.text,
            ),
            _selectorTematicas,
          ],
        ),
      ));

  Widget _userCategories() {
    if (_usuarioR.categories == null || _usuarioR.categories.isEmpty) {
      return Card(
        child: ListTile(
          title: Text(
            'No tiene categorías seleccionadas aún',
            style: TextStyle(fontSize: 15),
          ),
        ),
      );
    }
    return Card(
      child: ListTile(
        title: Text(
          'Categorías',
          style: TextStyle(fontSize: 15),
        ),
        subtitle: CategoryList(
          categories: _usuarioR.categories,
          wrap: true,
          dividerWidth: 5,
          usePadding: true,
          chipConstraints: true,
        ),
      ),
    );
  }

  Widget _signOutButton() => RaisedButton(
      color: Color(0xfff46352),
      child: Text("Cerrar sesion"),
      onPressed: () {
        _usuarioR
            .signOut()
            .then((value) => Navigator.pushReplacementNamed(context, '/'));
      });

  Widget _feedBackList() {
    if (_usuarioR.califications.isEmpty) {
      return Card(
          child: ListTile(
              title: Text(
        "No tiene calificaciones aún",
        style: TextStyle(fontSize: 15),
      )));
    }
    List feedbacks = _usuarioR.califications
        .map((feedback) => Card(
                child: ListTile(
              title: MentoringPoints(
                  truncateDouble(feedback['points'], 1), LightColor.seeBlue),
              subtitle: feedback['coment'] != null && feedback['coment'] != ''
                  ? Text(truncateText(feedback['coment'], COMENT_MAX_LENGTH))
                  : null,
            )))
        .toList();
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                "Calificaciones",
                style: TextStyle(fontSize: 15),
              )),
          Expanded(
            child: ListView(
              children: feedbacks,
            ),
          )
        ],
      ),
    );
  }

  void _saveChanges() {
    if (_keyForm.currentState.validate()) {
      setState(() => _loading = true);
      _usuarioR.name = _nameField.text.trim();
      _usuarioR.categories = _selectorTematicas.selectedCategories;
      _selectorTematicas = new SelectorTematicas(
          title: "Temática de interes",
          selectedCategories: _usuarioR.categories);
      _usuarioR
          .updateUser()
          .then((response) => setState(() {
                _editMode = false;
                _loading = false;
              }))
          .catchError((error) => print(error));
    }
  }

  Widget _saveButton() => Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.lerp(
                Alignment.bottomRight, Alignment.centerRight, 0.17),
            child: FloatingActionButton(
              heroTag: 'cancel-edit-user-btn',
              onPressed: () => _handleConnectivity(onSuccess: () {
                setState(() => _editMode = false);
              }, onError: () {
                _showNotConnectedDialog(context);
              }),
              child: Icon(Icons.cancel),
              backgroundColor: Colors.redAccent,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'save-edit-user-btn',
              backgroundColor: LightColor.purple,
              onPressed: () => _handleConnectivity(onSuccess: () {
                _saveChanges();
              }, onError: () {
                _showNotConnectedDialog(context);
              }),
              child: Icon(Icons.save),
            ),
          ),
        ],
      );

  Widget _editButton() => Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.lerp(
                Alignment.bottomRight, Alignment.centerRight, 0.17),
            child: FloatingActionButton(
              heroTag: 'user-mentorings-btn',
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new OwnMentorings())),
              child: Icon(Icons.dns),
              backgroundColor: LightColor.purple,
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              heroTag: 'edit-user-btn',
              onPressed: () => _handleConnectivity(onSuccess: () {
                setState(() => _editMode = true);
              }, onError: () {
                _showNotConnectedDialog(context);
              }),
              child: Icon(Icons.edit),
              backgroundColor: LightColor.orange,
            ),
          ),
        ],
      );

  // Widget build(BuildContext context) {
  //   return MainLayout(
  //     title: 'Perfil',
  //     body: Container(
  //         child: _loading
  //             ? Loading()
  //             : _editMode ? _formEdicionUsuario() : _paginaUsuario()),
  //     floatingActionButton: _editMode ? _saveButton() : _editButton(),
  //   );
  // }

  Widget _showPage() {
    return MainLayout(
      title: 'Perfil',
      body: Container(
          child: _loading
              ? Loading()
              : _editMode ? _formEdicionUsuario() : _paginaUsuario()),
      floatingActionButton: _editMode ? _saveButton() : _editButton(),
    );
  }

  Widget _showNotConnectedPage() {
    return MainLayout(
      title: "Perfil",
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

//Imagen perfil
class ImagenPerfil extends StatelessWidget {
  final UserModel _user;

  ImagenPerfil({UserModel user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: CircleAvatar(
      radius: 60,
      backgroundColor: Color(0xffb9e6fc),
      child: ClipOval(
        child: new SizedBox(
          width: 110.0,
          height: 110.0,
          child: Image.network(
            _user.imgPath != null && _user.imgPath.isNotEmpty
                ? _user.imgPath
                : "http://icons.iconarchive.com/icons/papirus-team/papirus-status/128/avatar-default-icon.png",
            fit: BoxFit.fill,
          ),
        ),
      ),
    ));
  }
}

class ContenedorEdit extends StatefulWidget {
  final UserModel _usuarioR;

  ContenedorEdit({@required UserModel user}) : _usuarioR = user;

  @override
  _ContenedorEditState createState() => _ContenedorEditState(user: _usuarioR);
}

class _ContenedorEditState extends State<ContenedorEdit> {
  UserModel _usuarioR;

  _ContenedorEditState({@required UserModel user}) : _usuarioR = user;

  Widget _paginaUsuario() => Container(
        width: 310.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text("Nombre"),
                subtitle: Text(truncateText(_usuarioR.name, NAME_MAX_LENGTH)),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text("Email"),
                subtitle: Text(truncateText(_usuarioR.email, EMAIL_MAX_LENGTH)),
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => _paginaUsuario();
}

class InputLogin extends StatelessWidget {
  final Key key;
  final Icon fieldIcon;
  final String hintText;
  final Function validator;
  final bool requiredField;
  final bool pasword;
  final TextEditingController controller;
  final TextInputType inputType;

  InputLogin(this.key, this.fieldIcon, this.hintText,
      {this.validator,
      this.requiredField = false,
      this.pasword,
      this.controller,
      this.inputType})
      : super();

  String _innerValidator(value) {
    if (this.requiredField && value.isEmpty)
      return 'Este campo no puede ir vacío';

    if (this.validator != null) {
      String errorMessage = this.validator(value);
      return errorMessage;
    }

    return null;
  }

  InputDecoration _innerTextFieldDecorationA() => InputDecoration(
        border: InputBorder.none,
        hintText: hintText,
        fillColor: Colors.white,
        filled: true,
      );

  Widget _input() => TextFormField(
        obscureText: pasword,
        key: this.key,
        validator: _innerValidator,
        decoration: _innerTextFieldDecorationA(),
        style: TextStyle(fontSize: 20, color: Colors.black),
        controller: this.controller,
        keyboardType: this.inputType,
      );

  BoxDecoration _inputContainerDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.horizontal(right: Radius.circular(8)));

  Widget _inputLayout({child}) => Container(
        child: Material(
            elevation: 10,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.deepOrange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                fieldIcon,
                Container(
                  decoration: _inputContainerDecoration(),
                  constraints: BoxConstraints(
                      maxWidth: 280, minWidth: 200, maxHeight: 58),
                  child:
                      Padding(padding: const EdgeInsets.all(3), child: child),
                ),
              ],
            )),
      );

  @override
  Widget build(BuildContext context) => _inputLayout(child: _input());
}
