import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/stars_points.dart';

class UserPage extends StatefulWidget {
  State<StatefulWidget> createState() {
    return UserPageState();
  }
}

class UserPageState extends State<StatefulWidget> {
  UserModel _usuarioR;
  bool _loading = true;

  @override
  void initState() {
    UserModel.getCurrentUser().then((usuario) {
      setState(() {
        this._usuarioR = usuario;
        _loading = false;
      });
    });
  }

  Widget _paginaUsuario() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
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

              //Editar perfil
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[ContenedorEdit(user: _usuarioR,)],
                  )
                  //Text('estamos aqui'),

                  //contenedorEdit()
                ],
              )
            ],
          );

  Widget build(BuildContext context) {
    return MainLayout(
        title: 'Perfil',
        body: Container(
          child: _loading ? Loading() : _paginaUsuario()
        )
      );
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

class nombrePuntuacion extends StatelessWidget {
  String nombre;

  nombrePuntuacion(nombre) {
    this.nombre = nombre;
  }
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Text(nombre,
            style: TextStyle(color: Colors.blueGrey, fontSize: 12.0)));
  }
}

class estrellaPuntuacion extends StatelessWidget {
  String estrellaP;

  estrellaPuntuacion(estrellaP) {
    this.estrellaP = estrellaP;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
        //numero Estrella
        children: <Widget>[
          Container(
              child: Align(
            alignment: Alignment.center,
            child: Text(estrellaP),
          )),

          //Estrella
          Container(
              child: const Align(
                  alignment: Alignment.center,
                  child: Icon(Icons.stars, color: Color(0xfffbbd5c))))
        ]);
  }
}

class ContenedorEdit extends StatefulWidget {
  final UserModel _usuarioR;

  ContenedorEdit({@required UserModel user}): _usuarioR=user;

  @override
  _ContenedorEditState createState() => _ContenedorEditState(user: _usuarioR);
}

class _ContenedorEditState extends State<ContenedorEdit> {
  UserModel _usuarioR;

  _ContenedorEditState({@required UserModel user}): _usuarioR=user;

  Widget _paginaUsuario() => Container(
      width: 310.0,
      height: 410.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.people),
              title: Text("Nombre"),
              subtitle: Text(_usuarioR.name),
            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.email),
              title: Text("Email"),
              subtitle: Text(_usuarioR.email),
            ),
          ),
          RaisedButton(
              color: Color(0xfff46352),
              child: Text("Cerrar sesion"),
              onPressed: () {
                _usuarioR.signOut().then((value) => Navigator.pushReplacementNamed(context, '/'));
              })
        ],
      ),
    );

  @override
  Widget build(BuildContext context) =>
    _paginaUsuario();
}

class edit extends StatelessWidget {
  Icon iconos;
  String nombreIconos;
  //String nombreInput;
  edit(iconos, nombreIconos) {
    this.iconos = iconos;
    this.nombreIconos = nombreIconos;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[iconosEdit(iconos), Text(nombreIconos)],
    );
  }
}

class iconosEdit extends StatelessWidget {
  Icon iconos;

  iconosEdit(iconos) {
    this.iconos = iconos;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Icon(
      iconos.icon,
      color: Color(0xff7a81dd),
      size: 24.0,
    ));
  }
}
