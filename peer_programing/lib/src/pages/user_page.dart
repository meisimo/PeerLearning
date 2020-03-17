
import 'package:flutter/material.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Text(
                                'Email',
                                textAlign : TextAlign.justify,
                                style: TextStyle(
                                color: Colors.blueGrey, fontSize: 12.0)
                                ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child:Text('michelleJames@gmail.com',
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
              )
            ],
          ),
        )
    );
  }
}