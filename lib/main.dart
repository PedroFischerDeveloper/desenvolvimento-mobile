import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _toDoList = ["PEDRO", "GUILHERME", "LUCAS"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsents.fromLTRB(20.0, 5.0, 10.0, 1.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                    labelText: "Nova Tarefa",
                    labelStyle: TextStyle(color: Colors.blueAccent)
                    ),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent, 
                  child: Text("ADD"),
                  textColor: Colors.white,
                  onPressed: () {  },
                )
              ],
             ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsents.only(top: 10.0),
                      itemCount: _toDoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_toDoList[index])
                        );
                    }),
                  )
                ],
                ),
            );
            }
                  
                Future<File> _getFile() async {
                  final directory = await getApplicationDocumentsDirectory();
                  return File("${directory.path}/data.json");
                }
              
                Future<File> _saveData() async {
                  String data = json.encode(_toDoList); 
                  final file = await _getFile();
                  return file.writeAsString(data);
                }
              
                Future<String> _readData() async {
                  try {
                    final file  = await _getFile();
              
                    return file.readAsString();
              
                  } catch(e) {
                    return null;
                  }
                }
              }
              
              class EdgeInsents {
                static fromLTRB(double d, double e, double f, double g) {}
      
        static only({double top}) {}
}

