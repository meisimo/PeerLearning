import 'package:flutter/material.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/dummy/users.dart';
import 'package:peer_programing/src/widgets/dropdown.dart';
import 'package:peer_programing/src/widgets/utils/validations/contraRepetidaValidations.dart';
import 'package:peer_programing/src/widgets/utils/validations/email-validatiom.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  String _title;
  bool _signUpMode;
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();

  _LoginPage() : super() {
    _title = 'Login';
    _signUpMode = false;
  }

  void _sendLogin() {
    Navigator.pushReplacementNamed(context, '/');
  }

  void _sendSignUp() {
    Navigator.pushReplacementNamed(context, '/');
  }

  Widget _submitFormButton({String text, VoidCallback onPressed}) => Container(
        width: 150,
        child: RaisedButton(
          onPressed: onPressed,
          color: Colors.deepOrange,
          textColor: Colors.white,
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

  Widget _loginButton() => _submitFormButton(
        text: 'Ingresar',
        onPressed: () {
          if (_loginFormKey.currentState.validate()) {
            _sendLogin();
          }
        },
      );

  Widget _signupButton() => _submitFormButton(
        text: 'Registrate',
        onPressed: () {
          if (_signUpKey.currentState.validate()) {
            _sendSignUp();
          }
        },
      );

  Widget _toggleButton({String text, VoidCallback onPressed}) => Container(
        width: 150,
        child: RaisedButton(
          onPressed: onPressed,
          color: Colors.deepOrange,
          textColor: Colors.white,
          child: Text(
            text,
            style: TextStyle(fontSize: 20),
          ),
        ),
      );

  Widget _showSignUpButton() => _toggleButton(
      text: "Registrate",
      onPressed: () {
        setState(() {
          this._title = "Registro";
          this._signUpMode = true;
        });
      });

  Widget _showLoginButton() => _toggleButton(
      text: "Cancelar",
      onPressed: () {
        setState(() {
          this._title = "Login";
          this._signUpMode = false;
        });
      });

  Widget _formLayout({Widget form, Widget submitButton, Widget toggleButton}) =>
      Container(
          child: Center(
              child: Container(
                  width: 600,
                  child: Column(
                    children: <Widget>[form, submitButton, toggleButton],
                  ))));

  @override
  Widget build(BuildContext context) => MainLayout(
      title: _title,
      body: Container(
        child: Center(
          child: _formLayout(
              form: this._signUpMode
                  ? SignupForm(this._signUpKey)
                  : LoginForm(this._loginFormKey),
              submitButton: this._signUpMode ? _signupButton() : _loginButton(),
              toggleButton:
                  this._signUpMode ? _showLoginButton() : _showSignUpButton()),
        ),
      ));
}

class LoginForm extends StatefulWidget {
  final _formKey;
  LoginForm(this._formKey);
  @override
  _LoginForm createState() => _LoginForm(_formKey);
}

class _LoginForm extends State<LoginForm> {
  final _formKey;

  _LoginForm(this._formKey) : super();

  Widget _loginIcon() => Image.asset(
        daticosDummy[0].avatar,
        width: 200,
        height: 100,
      );


  List<Widget> _loginInputs() => <Widget>[
        InputLogin(
          Key('input-email'),
          Icon(
            Icons.people,
            color: Colors.white,
          ),
          'Email',
          pasword: false,
          requiredField: true,
          validator: EmailValidations.emailValidation,
        ),
        InputLogin(
          Key('input-contraseña'),
          Icon(
            Icons.lock,
            color: Colors.white,
          ),
          
          'Contraseña',
           pasword: true,
          requiredField: true,
          validator: EmailValidations.validaUsuario,

        ),
      ];

  Widget _forgotYourPassword() => InkWell(
        child: Text("Olvidaste tu contraseña"),
        onTap: () async {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Alert Dialog"),
                  content: Text("Ejemplo"),
                );
              });
        },
      );

  @override
  Widget build(BuildContext context) => Form(
      key: _formKey,
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [_loginIcon()]..addAll(_loginInputs()),
        ),
      ));
}

class SignupForm extends StatefulWidget {
  final _formKey;

  SignupForm(this._formKey) : super();

  @override
  _SignupForm createState() => _SignupForm(this._formKey);
}

class _SignupForm extends State<SignupForm> {
  final _formKey;

  _SignupForm(this._formKey) : super();

  List<Widget> _signupInputs() => <Widget>[
        InputLogin(
          Key('input-nombre'),
          Icon(
            Icons.person,
            color: Colors.white,
          ),
          "Nombre",
          pasword: false,
          requiredField: true,
        ),
        InputLogin(
          Key('input-correo'),
          Icon(
            Icons.email,
            color: Colors.white,
          ),
          "Correo",
          pasword: false,
          requiredField: true,
          validator: EmailValidations.emailValidation,
        ),
        InputLogin(
          Key('input-contraseña'),
          Icon(
            Icons.lock_open,
            color: Colors.white,
          ),
          "Contraseña",
          pasword: true,
          requiredField: true,
          validator: ContraRepetidaValidation.contraseValidation,

        ),
        InputLogin(
          Key('input-contraseña-compartida'),
          Icon(
            Icons.lock_open,
            color: Colors.white,
          ),
          "Confirmar contraseña",
          pasword: true,
          requiredField: true,
          validator: ContraRepetidaValidation.contraseValidationReal,
        ),
        LDropDown(),
      ];

  @override
  Widget build(BuildContext context) => Form(
      key: _formKey,
      child: Container(
        height: 490,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _signupInputs(),
        ),
      ));
}

class InputLogin extends StatelessWidget {
  final Key key;
  final Icon fieldIcon;
  final String hintText;
  final Function validator;
  final bool requiredField;
  final bool pasword;

  InputLogin(this.key, this.fieldIcon, this.hintText,
      {this.validator, this.requiredField = false, this.pasword})
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
      // enabledBorder: const OutlineInputBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(40.0)),
      //     borderSide: const BorderSide(
      //       color: Colors.red,
      //     ))
          );

  Widget _input() => TextFormField(
        obscureText: pasword,
        key: this.key,
        validator: _innerValidator,
        decoration: _innerTextFieldDecorationA(),
        style: TextStyle(fontSize: 20, color: Colors.black),
      );

  BoxDecoration _inputContainerDecoration() => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topRight: Radius.circular(10)));

  Widget _inputLayout({child}) => Container(
        width: 240,
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
                  width: 200,
                  child:
                      Padding(padding: const EdgeInsets.all(8), child: child),
                ),
              ],
            )),
      );

  @override
  Widget build(BuildContext context) => _inputLayout(child: _input());
}
