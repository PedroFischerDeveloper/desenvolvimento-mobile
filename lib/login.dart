import 'package:flutter/material.dart';
import 'register.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  void navigateToHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void navigateToRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Colors.green,
          centerTitle: true,
        ),
        body: Container(
            padding: EdgeInsets.all(16),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          labelStyle: TextStyle(color: Colors.green),
                          hintText: "Digite seu e-mail",
                        ),
                        controller: controllerEmail,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          labelStyle: TextStyle(color: Colors.green),
                          hintText: "Digite sua senha",
                        ),
                        controller: controllerSenha,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: RaisedButton(
                                    onPressed: navigateToHome,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Text('Logar',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18)),
                                    color: Colors.green)),
                          ],
                        )),
                    Padding(
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
                        ))
                  ],
                ))));
  }
}
