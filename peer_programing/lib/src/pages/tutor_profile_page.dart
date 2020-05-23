import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/user_model.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/src/widgets/loading.dart';
import 'package:peer_programing/src/widgets/stars_points.dart';

class TutorProfilePage extends StatefulWidget {
  final UserModel tutor;
  TutorProfilePage({this.tutor});

  State<StatefulWidget> createState() {
    return TutorProfileState(tutor: this.tutor);
  }
}

class TutorProfileState extends State<StatefulWidget> {
  final UserModel tutor;

  TutorProfileState({this.tutor});

  Widget _paginaUsuario() => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Image of profile
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImagenPerfil(
                    user: tutor,
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
                      StartsPoints(5, tutor.points)
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
                    children: <Widget>[ContenedorEdit(user: tutor,)],
                  )
                  //Text('estamos aqui'),

                  //contenedorEdit()
                ],
              )
              //Text(tutor.name , style: TextStyle(fontSize: 32),)
            ],
          );

  Widget build(BuildContext context) {
    print(tutor);
    return MainLayout(
        title: 'Perfil del Tutor',
        withBottomNavBar: false,
        body: Container(
          child: _paginaUsuario()
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
        ],
      ),
    );

  @override
  Widget build(BuildContext context) =>
    _paginaUsuario();
}
