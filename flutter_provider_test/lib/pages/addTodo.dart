import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../todoData.dart';

class AddTodoPage extends StatefulWidget {
  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  String taskDescription;

  void _addTodo(context) {
    if (taskDescription == null) {
      toastWidget("Give task a description");
      return;
    }
    if (taskDescription.length < 2) {
      toastWidget("Description must be longer text");
      return;
    }
    Todo newTodo = Todo(taskDescription: taskDescription, isComplete: false);

    Provider.of<TodoData>(context, listen: false)
        .addTodo(newTodo);
    Provider.of<TodoData>(context, listen: false).setActiveTodo(newTodo.key);

    Navigator.pop(context, 'Added todo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 16.0,
        title: Text(
          "Add Todo",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              iconSize: 24.0,
              color: Colors.black,
              tooltip: "Save",
              onPressed: () {
                _addTodo(context);
              })
        ],
      ),
      body: Center(
          child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: "Description"),
              onChanged: (descriptionInputed) {
                setState(() {
                  taskDescription = descriptionInputed;
                });
              },
            )
          ],
        ),
      )),
    );
  }
}
