import 'package:flutter/material.dart';
import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MainLayout(
        title: "Login",
        body: Container(
            child: Center(
              child: Container(
              width: 600,
              height: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Image.asset('images/avatar-default-icon.png',width: 200,height: 100,),
                  InputLogin(
                    Icon(Icons.people,color: Colors.white,), 'Usuario'),
                    InputLogin(
                    Icon(Icons.lock,color: Colors.white,), 'Contraseña'
                    ),
                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();    
                        await prefs.setBool('logged', true);
                        Navigator.pushReplacementNamed(

                              context,
                              '/',
                            );
                        },
                        color: Colors.deepOrange,textColor: Colors.white,
                      
                      
                      child: Text("Entrar",style: TextStyle(
                        fontSize: 20
                      ),),),
                    ),
                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Registro()),
                            );
                        },
                        color: Colors.deepOrange,textColor: Colors.white,
                      
                      
                      child: Text("Registrarse",style: TextStyle(
                        fontSize: 20
                      ),),),
                    ),

                  ]

                  
                  ),
            )
          )
        )
      );
  }
}

class Registro extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MainLayout(
        title: "Registro",
        body: Container(
            child: Center(
              child: Container(
              width: 600,
              height: 520,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    InputLogin(Icon(Icons.person,color: Colors.white,),"Nombre"),
                    InputLogin(Icon(Icons.email, color: Colors.white,),"Correo"),
                    InputLogin(Icon(Icons.lock_open,color: Colors.white,),"Contraseña"),
                    InputLogin(Icon(Icons.lock_open,color: Colors.white,),"Confirmar contraseña"),
                    InputLogin(Icon(Icons.lock_open,color: Colors.white,),"Tutoria"),

                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: () {
                          Navigator.pushReplacementNamed(context,'/');
                        },color: Colors.deepOrange,textColor: Colors.white, 
                      child: Text("Registrarse",style: TextStyle(
                        fontSize: 20
                      ),),),
                    ),
                       Container(
                      width: 150,
                      child: RaisedButton(onPressed: () {
                          Navigator.pop(
                              context,
                            );
                        },
                        color: Colors.deepOrange,textColor: Colors.white,
                      
                      
                      child: Text("Login",style: TextStyle(
                        fontSize: 20
                      ),),),
                    )
                  ]
                  
                  ),
            )
          )
        )
      );
  }

}
class InputLogin extends StatelessWidget {

  Icon fieldIcon;
  String hintText;
  String valor;


  InputLogin(this.fieldIcon,this.hintText);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240,
      child: Material(
          elevation: 8,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.deepOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //icono
              fieldIcon,
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(10))),
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                        
                            onChanged: (texto) {
                              valor = texto;
                            },
                          
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hintText,
                        fillColor: Colors.white,
                        filled: true),
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ],
          )),
    );
    
  }
    String Devolver(){
    return valor;
  }
}
