import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/widgets/todoList.dart';
import 'package:provider/provider.dart';

import '../todoData.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 16.0,
          title: Text("To-dos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Expanded(child: Container(child: TodoList()))],
      )),
      floatingActionButton: AddTodoButton(),
    );
  }
}

class AddTodoButton extends StatelessWidget {
  _navigateAndDisplayAction(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/AddTodoPage');

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text("$result",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: (){
              Todo currentTodo = Provider.of<TodoData>(context, listen: true).getActiveTodo();
              Provider.of<TodoData>(context, listen: true).deleteTodo(currentTodo.key);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      tooltip: "Add",
      child: Icon(Icons.add),
      onPressed: () {
        _navigateAndDisplayAction(context);
      },
    );
  }
}
