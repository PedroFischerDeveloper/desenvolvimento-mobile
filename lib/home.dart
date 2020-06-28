import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _toDoController = TextEditingController();

  List _toDoList = [];

  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    if (_formKey.currentState.validate()) {
      setState(() {
        Map<String, dynamic> newToDo = Map();
        newToDo["title"] = _toDoController.text.trim();
        newToDo["checked"] = false;

        _toDoList.add(newToDo);

        _toDoController.clear();

        _saveData();
      });
    }
  }

  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _toDoList.sort((a, b) {
        if (a["checked"] && !b["checked"])
          return 1;
        else if (!a["checked"] && b["checked"])
          return -1;
        else
          return 0;
      });

      _saveData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.fromLTRB(17.0, 1.0, 7.0, 1.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: TextFormField(
                        controller: _toDoController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Preencha o campo com uma nova tarefa';
                          }

                          if (value.trim() == '') {
                            return 'Preencha o campo com uma nova tarefa';
                          }

                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Tarefa",
                            labelStyle: TextStyle(color: Colors.green)),
                      )),
                      FlatButton(
                        color: Colors.green,
                        child: Icon(Icons.add),
                        textColor: Colors.white,
                        onPressed: _addToDo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ])),
            Expanded(
                child: RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.0),
                  itemCount: _toDoList.length,
                  itemBuilder: buildItem),
            ))
          ])),
    );
  }

  Widget buildItem(BuildContext context, int index) {
    return Dismissible(
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["checked"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["checked"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["checked"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);

          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 2),
          );

          Scaffold.of(context).removeCurrentSnackBar();
          Scaffold.of(context).showSnackBar(snack);
        });
      },
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
      final file = await _getFile();

      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
