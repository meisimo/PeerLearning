import 'package:flutter/material.dart';
import 'package:peer_programing/dummy/users.dart';
import 'package:peer_programing/src/pages/home_page.dart';
import 'package:peer_programing/src/widgets/dropdown.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';


class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MainLayout(
        title: "Login",
        body: Container(
            child: Center(
              child: Container(
              width: 320,
              height: 400,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                  Image.asset(daticosDummy[0].avatar,width: 200,height: 100,),
                  
              TextFormField(
                   
                  decoration: new InputDecoration(
                  icon: new Icon(Icons.email,color: Colors.red,),
                  hintText: "Email",
                  enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: const BorderSide(
                  color: Colors.red,
                 ),
               ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),

              TextFormField(
                obscureText: true,
                  decoration: new InputDecoration(
                  icon: new Icon(Icons.lock,color: Colors.red,),
                  hintText: "Contraseña",
                  enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: const BorderSide(
                  color: Colors.red,
                 ),
               ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
            InkWell(
              child: Text("Olvidaste tu contraseña"),
              onTap: () async{
                showDialog(
                context: context,
                builder: (BuildContext context){
                return AlertDialog(
                title: Text("Alert Dialog"),
                content: Text("Ejemplo"),
                );
              }
              );
              },
            ),
                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: () {
                        //   showDialog(
                        //   context: context,
                        //   builder: (BuildContext context){
                        //       return AlertDialog(
                        //         title: Text("Alert Dialog"),
                        //         content: Text("Dialog Content"),
                        //       );
                        //   }
                        // );
                        Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
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
              width: 350,
              height: 520,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                     
                TextFormField(
                  decoration: new InputDecoration(
                  icon: new Icon(Icons.person,color: Colors.red,),
                  hintText: "Nombre",
                  enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: const BorderSide(
                  color: Colors.red,
                 ),
               ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
                TextFormField(
                  decoration: new InputDecoration(
                  icon: new Icon(Icons.email,color: Colors.red,),
                  hintText: "Correo",
                  enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: const BorderSide(
                  color: Colors.red,
                 ),
               ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
                TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                  icon: new Icon(Icons.lock,color: Colors.red,),
                  hintText: "Contraseña",
                  enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: const BorderSide(
                  color: Colors.red,
                 ),
               ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
                TextFormField(
                  obscureText: true,
                  decoration: new InputDecoration(
                  icon: new Icon(Icons.lock,color: Colors.red,),
                  hintText: "Confirmar contraseña",
                  enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  borderSide: const BorderSide(
                  color: Colors.red,
                 ),
               ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                borderSide: BorderSide(color: Colors.red),
                ),
              ),
            ),
                //lista desplegable
                LDropDown(),
                    Container(
                      width: 150,
                      child: RaisedButton(onPressed: () {
                             Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );

                        },color: Colors.deepOrange,textColor: Colors.white, 
                      child: Text("Registrarse",style: TextStyle(
                        fontSize: 20
                      ),),),
                    ),
                       Container(
                      width: 150,
                      child: RaisedButton(onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
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
