import 'package:flutter/material.dart';
import 'package:todo/authentication.dart';
import 'package:todo/home.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  String _errorMessage = "";
  bool _isLoading = false;

  String _email;
  String _password;

  final _formKey = new GlobalKey<FormState>();

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

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });

    if (validateAndSave()) {
      String userId = "";
      try {
        userId = await widget.auth.signUp(_email, _password);
        print('Signed in: $userId');

        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.loginCallback();
          navigateToHome();
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
                  Padding(
                      padding: EdgeInsets.only(bottom: 0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: RaisedButton(
                            elevation: 4,
                            onPressed: validateAndSubmit,
                            child: Text('Cadastrar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          )),
                        ],
                      ))
                ])));
  }

  void navigateToHome() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Stack(
                children: <Widget>[_showForm(), _showCircularProgress()],
              ),
            )));
  }
}
