import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:peer_programing/src/helper/auth_module.dart';
import 'package:peer_programing/src/helper/mentoring_category_model.dart';
import 'package:peer_programing/src/utils/connection.dart';
import 'package:peer_programing/src/widgets/layouts/main_layout.dart';
import 'package:peer_programing/dummy/users.dart';
import 'package:peer_programing/src/widgets/dropdown.dart';
import 'package:peer_programing/src/widgets/tarjetas/not_connected.dart';
import 'package:peer_programing/src/widgets/utils/validations/contraRepetidaValidations.dart';
import 'package:peer_programing/src/widgets/utils/validations/email-validatiom.dart';

import '../../routes.dart';

class LoginPage extends StatefulWidget {
  final bool _betweenAction;

  LoginPage({bool betweenAction=false}):_betweenAction=betweenAction;

  @override
  _LoginPage createState() => _LoginPage(betweenAction: _betweenAction);
}

class _LoginPage extends State<LoginPage> {
  String _title, _singInError, _singUpError;
  bool _checkConnection = true;
  bool _connected = false;
  bool _signUpMode;
  SignupForm _signupFormWidget;
  final bool _betweenAction;
  final _loginFormKey = GlobalKey<FormState>();
  final _signUpKey = GlobalKey<FormState>();

  BasicAuth auth = Routes.auth;

  _LoginPage({bool betweenAction}):
    _title = 'Login',
    _signUpMode = false,
    _betweenAction = betweenAction,
    super();

  void _getOut() {
    if (_betweenAction)
      Navigator.pop(context);
    else
      Navigator.pushReplacementNamed(context, '/');
  }

  void _sendLogin() {
    _singInError = null;
    String email = _LoginForm(this._loginFormKey).getEmailField();
    String pass = _LoginForm(this._loginFormKey).getPasswordField();
    auth
      .signIn(email, pass)
      .then((loginResult){
        _getOut();
        _LoginForm(this._loginFormKey).clearSignInFields();
      })
      .catchError(
        (error){
          if(error.code == "ERROR_USER_NOT_FOUND" || error.code == "ERROR_WRONG_PASSWORD"){
            _singInError = "El email y/o contraseña no es válida.";
          } else{
            _singInError = "Ha ocurrido un error inesperado, porfavor intentelo más tarde.";
          }
          _loginFormKey.currentState.validate();
        });
  }

  void _sendSignUp() {
    _singUpError = null;
    String email = _SignupForm(this._signUpKey).getEmailField();
    String pass = _SignupForm(this._signUpKey).getPasswordField();
    String name = _SignupForm(this._signUpKey).getNameField();
    List<DocumentReference> categories = _signupFormWidget.getTematicas().map<DocumentReference>((MentoringCategory category) => category.reference).toList();
    auth
      .signUp(name, email, pass, categories)
      .then((signUpResult){
        _getOut();
        _SignupForm(this._signUpKey).clearSignUpFields();
      })
      .catchError((error){
        if (error.code == "ERROR_WEAK_PASSWORD")
          _singUpError = "La contraseña es demasiado debil.";
        else if(error.code == "ERROR_EMAIL_ALREADY_IN_USE")
          _singUpError = "Este correo ya se encuentra registrado.";
        else 
          _singUpError = "Error inesperado en el registro";
        _signUpKey.currentState.validate();
      });
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
        onPressed: () => _handleConnectivity(onSuccess: () {
          if (_loginFormKey.currentState.validate()) {
            _sendLogin();
        }}, onError: () {
             _showNotConnectedDialog(context);
        }),
      );

  Widget _signupButton() => _submitFormButton(
        text: 'Registrate',
        onPressed: () => _handleConnectivity(onSuccess: () {
          if (_signUpKey.currentState.validate()) {
            _sendSignUp();
          }
        },onError: () {
            _showNotConnectedDialog(context);
        }
      ));

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
      onPressed: ()  => _handleConnectivity(onSuccess: () {
        setState(() {
          this._title = "Registro";
          this._signUpMode = true;
      });
      },onError: () {
      //  Navigator.of(context).pop();
      _showNotConnectedDialog(context);
      }));
    

  Widget _showLoginButton() => _toggleButton(
      text: "Cancelar",
      onPressed: () => _handleConnectivity(onSuccess: () {
        setState(() {
          this._title = "Login";
          this._signUpMode = false;
        });
      },onError: (){
          _showNotConnectedDialog(context);
      }));

  Widget _formLayout({Widget form, Widget submitButton, Widget toggleButton}) =>
      Container(
          child: Center(
              child: Container(
                  width: 600,
                  child: Column(
                    children: <Widget>[form, submitButton, toggleButton],
                  ))));

  // @override
  // Widget build(BuildContext context) => MainLayout(
      
      
  //     );


  Widget _showPage() {
    return MainLayout(
     title: _title,
      body: Container(
        child: Center(
          child: _formLayout(
              form: this._signUpMode
                  ? _signupFormWidget = SignupForm(this._signUpKey, showError: (String _) => _singUpError,)
                  : LoginForm(this._loginFormKey, showError: (String _) => _singInError,),
              submitButton: this._signUpMode ? _signupButton() : _loginButton(),
              toggleButton:
                  this._signUpMode ? _showLoginButton() : _showSignUpButton()),
          ),
        ),
      withBottomNavBar: !this._betweenAction,
    );
  }



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

   Widget _showNotConnectedPage() {
    return MainLayout(
      title: _title,
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

class LoginForm extends StatefulWidget {
  final _formKey;
  final _signInDataWrapper = <_LoginForm>[null];
  final Function showError;
  LoginForm(this._formKey, {this.showError});
  @override
  _LoginForm createState() => _signInDataWrapper[0] = new _LoginForm(_formKey, showError: showError);
}

TextEditingController _emailSignInField = TextEditingController();
TextEditingController _passwordSignInField = TextEditingController();

class _LoginForm extends State<LoginForm> {
  Function showError;
  getEmailField() => _emailSignInField.text;
  getPasswordField() => _passwordSignInField.text;
  clearSignInFields() {
    _emailSignInField.clear();
    _passwordSignInField.clear();
  }
  final _formKey;

  _LoginForm(this._formKey, {Function this.showError}) : super();

  Widget _loginIcon() => Image.asset(
        daticosDummy[0].avatar,
        width: 200,
        height: 100,
      );

  List<Widget> _loginInputs() => <Widget>[
        Container(
          height: 20,
          child: TextFormField(
            readOnly: true,
            validator: showError,
            textAlign: TextAlign.center,
          ),
        ),
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
          controller: _emailSignInField,
          inputType: TextInputType.emailAddress,
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
          //validator: EmailValidations.validaUsuario,
          controller: _passwordSignInField,
          inputType: TextInputType.visiblePassword,
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


TextEditingController _emailSignUpField = TextEditingController();
TextEditingController _passwordSignUpField = TextEditingController();
TextEditingController _nameField = TextEditingController();

class SignupForm extends StatefulWidget {
  final _formKey;
  final _signUpDataWrapper = <_SignupForm>[null];
  final Function showError;

  SignupForm(this._formKey,{this.showError}) : super();

  @override
  _SignupForm createState() =>
      _signUpDataWrapper[0] = new _SignupForm(this._formKey, showError: showError);

  getTematicas() => _signUpDataWrapper[0].getTematicas();
  
}

class _SignupForm extends State<SignupForm> {
  Function showError;
  final _formKey;
  final SelectorTematicas _selectorTematicas = new SelectorTematicas(title: "Temática de interes");

  getTematicas() => _selectorTematicas.selectedCategories;
  getEmailField() => _emailSignUpField.text;
  getPasswordField() => _passwordSignUpField.text;
  getNameField() => _nameField.text;
  clearSignUpFields() {
    _emailSignUpField.clear();
    _passwordSignUpField.clear();
    _nameField.clear();
  }

  _SignupForm(this._formKey, {this.showError}) : super();

  List<Widget> _signupInputs() => <Widget>[
        Container(
          height: 20,
          child: TextFormField(
            readOnly: true,
            validator: showError,
            textAlign: TextAlign.center,
          ),
        ),
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
          controller: _emailSignUpField,
          inputType: TextInputType.emailAddress,
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
          inputType: TextInputType.visiblePassword,
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
          controller: _passwordSignUpField,
          inputType: TextInputType.visiblePassword,
        ),
        _selectorTematicas,
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
