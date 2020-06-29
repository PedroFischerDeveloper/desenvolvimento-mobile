import 'package:flutter/material.dart';
import 'package:todo/authentication.dart';
import 'register.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  String _errorMessage = "";
  bool _isLoading = false;

  String _email;
  String _password;

  final _formKey = new GlobalKey<FormState>();

  void navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void navigateToRegister() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegisterPage(
                  auth: widget.auth,
                  loginCallback: widget.loginCallback,
                )));
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    setState(() {
      _isLoading = false;
    });
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (validateAndSave()) {
      String userId = "";
      try {
        userId = await widget.auth.signIn(_email, _password);
        print('Signed in: $userId');

        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  Widget showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value.isEmpty) {
            return 'Preencha o campo com seu e-mail';
          }

          return null;
        },
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(color: Colors.green),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
        ),
        controller: _controllerEmail,
        onSaved: (value) => _email = value.trim(),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            labelText: "Senha",
            labelStyle: TextStyle(color: Colors.green),
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return 'Preencha o campo com sua senha';
          }

          return null;
        },
        controller: _controllerPassword,
        onSaved: (value) => _password = value.trim(),
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget showLoginButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: 0),
        child: Row(
          children: <Widget>[
            Expanded(
                child: RaisedButton(
                    elevation: 4,
                    onPressed: validateAndSubmit,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Text('Logar',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    color: Colors.green)),
          ],
        ));
  }

  Widget showRegisterButton() {
    return Padding(
        padding: EdgeInsets.only(bottom: 16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: FlatButton(
                onPressed: navigateToRegister,
                child: Text('Cadastrar-se',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    )),
              ),
            )
          ],
        ));
  }

  Widget showErrorMessage() {
    return _errorMessage != null && _errorMessage.length > 0
        ? Text(
            _errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.red,
                height: 1.0,
                fontWeight: FontWeight.w700),
          )
        : Container(
            height: 0.0,
          );
  }

  Widget _showForm() {
    return Container(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showErrorMessage(),
                showEmailInput(),
                showPasswordInput(),
                showLoginButton(),
                showRegisterButton(),
              ],
            )));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[_showForm(), _showCircularProgress()],
        ));
  }
}
