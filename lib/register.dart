import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Nome",
                          labelStyle: TextStyle(color: Colors.green),
                          hintText: "Digite seu nome",
                        ),
                        controller: controllerNome,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        cursorColor: Colors.green,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: TextStyle(color: Colors.green),
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.green)),
                        controller: controllerEmail,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: "Senha",
                            labelStyle: TextStyle(color: Colors.green),
                            hintStyle:
                                TextStyle(fontSize: 12, color: Colors.green)),
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
                              onPressed: () {},
                              child: Text('Enviar',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18)),
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                            )),
                          ],
                        )),
                  ],
                ))));
  }
}
