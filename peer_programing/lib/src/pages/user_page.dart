import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/box.dart';
import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';


/*class UserPage extends StatelessWidget{
  
  @override
  Widget build(BuildContext context){
    return MainLayout(
      title: 'Perfil',
      body:
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xffb9e6fc),
                        child: ClipOval(
                          child: new SizedBox(
                            width: 90.0,
                            height: 90.0,
                            child: Image.network(
                              "http://icons.iconarchive.com/icons/papirus-team/papirus-status/128/avatar-default-icon.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row( 
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Tutor',
                                style: TextStyle(
                                color: Colors.blueGrey, fontSize: 12.0)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                            child: Text('4'),
                                        ),

                                      const Align(
                                        alignment: Alignment.center,
                                            child: Icon(
                                              Icons.stars,
                                              color: Color(0xfffbbd5c)
                                            ),
                                      ),
                                      ],
                                  )
                                ],
                              )
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text('Estudiante',
                                style: TextStyle(
                                color: Colors.blueGrey, fontSize: 12.0)),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                            child: Text('4'),
                                        ),

                                      const Align(
                                        alignment: Alignment.center,
                                            child: Icon(
                                              Icons.stars,
                                              color: Color(0xfffbbd5c)
                                            ),
                                      ),
                                      ],
                                  )
                                ],
                              )
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ]
              ),
              SizedBox(
                height: 20.0,
              ),
              
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('Nombre',
                                  style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 12.0)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('Michelle James',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Icon(
                          Icons.edit,
                          color: Color(0xff7178d3)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('Email',
                                  style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 12.0)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('michelleJ@gmail.com',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Icon(
                          Icons.edit,
                          color: Color(0xff7178d3)
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('Contraseña',
                                  style: TextStyle(
                                  color: Colors.blueGrey, fontSize: 12.0)),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text('*******',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        child: Icon(
                          Icons.edit,
                          color: Color(0xff7178d3)
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child :RaisedButton(
                        color: Color(0xfff46352),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();    
                          await prefs.setBool('logged', false);
                          Navigator.pushReplacementNamed(
                            context,
                            '/'
                          );
                        },
                        child: const Text(
                          'Cerrar sesión',
                          style: TextStyle(fontSize: 20)
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
    );
  }
}*/

class UserPage extends StatefulWidget{
  State<StatefulWidget> createState(){
    return UserPageState();
  }
}

class UserPageState extends State<StatefulWidget> {
  Widget build(BuildContext context){
    var crossAxisAlignment;
    return MainLayout(
      title: 'Perfil',
      body: 
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Image of profile
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  imagenPerfil()
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
                    nombrePuntuacion('tutor'),
                    estrellaPuntuacion('4')
                  ],
                 ),

                 Column(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: <Widget>[
                    nombrePuntuacion('Estudiante'),
                    estrellaPuntuacion('3.5')
                   ],
                 )
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
                    children: <Widget>[
                      //contenedorEdit()
                    ],
                  )
                  //Text('estamos aqui'),
                 
                  //contenedorEdit()
                ],
              )
            ],
          ),
        )
      /*headerChild: Container(
        child: fondo()
      )*/
      );
    }
}

//Imagen perfil 
class imagenPerfil extends StatelessWidget{
  Widget build(BuildContext context){
    return new Container(
      child:  CircleAvatar(
        radius: 60,
        backgroundColor: Color(0xffb9e6fc),
        child: ClipOval(
          child: new SizedBox(
            width: 110.0,
            height: 110.0,
            child: Image.network(
              "http://icons.iconarchive.com/icons/papirus-team/papirus-status/128/avatar-default-icon.png",
              fit: BoxFit.fill,
            ),
          ),
        ),
      )
    );
  }
}

class nombrePuntuacion extends StatelessWidget{
  String nombre;

  nombrePuntuacion(nombre){
    this.nombre = nombre;
  }
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(nombre,
          style: TextStyle(
          color: Colors.blueGrey, fontSize: 12.0)
        )
    );
  }
}

class estrellaPuntuacion extends StatelessWidget{
  String estrellaP;

  estrellaPuntuacion(estrellaP){
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
          )
        ),

        //Estrella
        Container(
          child: const Align(
            alignment: Alignment.center,
                child: Icon(
                  Icons.stars,
                  color: Color(0xfffbbd5c)
                )
          )
        )  
      ]
    );
  }
}

class contenedorEdit extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
       width: 310.0,
       height: 410.0,
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xffd4d4ea)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'ajaagjh',
              border: const UnderlineInputBorder()
            ),
          )
          /*edit(Icon(Icons.edit), 'Nombre'),
          edit(Icon(Icons.edit), 'Email'),
          edit(Icon(Icons.edit), 'Numero')*/
        ],
      ),
    );
  }
}

class edit extends StatelessWidget{
  Icon iconos;
  String nombreIconos;
  //String nombreInput;
  edit(iconos, nombreIconos){
    this.iconos = iconos;
    this.nombreIconos= nombreIconos;
  }

  @override
  Widget build (BuildContext context){
    return Row(
      children: <Widget>[
        iconosEdit(iconos),
        Text(nombreIconos)
      ],
    );
  }
}

class iconosEdit extends StatelessWidget{
  Icon iconos;

  iconosEdit(iconos){
    this.iconos = iconos;
  }
  @override
  Widget build (BuildContext context){
    return Container(
      child: Icon(
        iconos.icon,
        color: Color(0xff7a81dd),
        size: 24.0,
      )
    );
  }
}