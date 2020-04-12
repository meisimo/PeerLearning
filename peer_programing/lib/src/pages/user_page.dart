
import 'package:flutter/material.dart';
import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserPage extends StatelessWidget{
  
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
}
