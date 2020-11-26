import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/pages/todoEdit.dart';
import 'package:provider/provider.dart';

import '../todoData.dart';
import '../utils.dart';

class TodoView extends StatelessWidget {
  void _deleteConfirmation(BuildContext context, Todo currentTodo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Are you sure?', style: TextStyle(color: Colors.black)),
          content: SingleChildScrollView(
              child: ListBody(
            children: <Widget>[
              Text('You are about to delete a todo'),
              SizedBox(
                height: 10.0,
              ),
              Text("This action cannot be undone")
            ],
          )),
          actions: <Widget>[
            FlatButton(
              child: Text("DELETE",
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Log.d("Deleting todo");
                Provider.of<TodoData>(context, listen: false)
                    .deleteTodo(currentTodo.key);

                Navigator.popUntil(
                  context,
                  ModalRoute.withName(Navigator.defaultRouteName),
                );
              },
            ),
            FlatButton(
              child: Text(
                "Cancel",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Log.d("Cancelling");
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var currentTodo =
        Provider.of<TodoData>(context, listen: true).getActiveTodo();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 16.0,
        title: Text(
          currentTodo.taskDescription,
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.create),
            iconSize: 24.0,
            color: Colors.black,
            tooltip: "Edit",
            onPressed: () {
              Log.d("Selected to edit");
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TodoEditPage(currentTodo: currentTodo);
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            iconSize: 24.0,
            color: Colors.red,
            tooltip: "Delete",
            onPressed: () {
              Log.d("Selected for deletion");
              _deleteConfirmation(context, currentTodo);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 36.0,
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Text(currentTodo?.taskDescription,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 36.0,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    "Completed",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Switch(
                    activeTrackColor: Colors.black,
                    value: currentTodo.isComplete,
                    onChanged: (bool value) {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
