import 'package:peer_programing/dummy/users.dart';
import 'package:flutter/material.dart';

class EmailValidations{
static String emailUsuario;
static String emailValidation(email) {
    emailUsuario=email;
    RegExp emailRegex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$");
    if (emailRegex.stringMatch(email) == email) return null;
    return "El email ingresado no es válido.";
  }

  static String validaUsuario(contrasena){

    for(int i=0; i<daticosDummy.length; i++){
    if(contrasena==daticosDummy[i].contrasena && emailUsuario==daticosDummy[i].email ) return null;
    }
    return  "Usuario invalido verifique sus datos";
  }
    }
  




