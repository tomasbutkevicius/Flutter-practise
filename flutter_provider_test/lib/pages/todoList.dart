import 'package:flutter/material.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:flutter_provider_test/widgets/todoList.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TodoData>(context, listen: true).getTodos();

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 16.0,
          title: Text("To-dos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Expanded(
              child: Container(
                child: TodoList()
              )
            )
          ],
        )
      ),
        floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
      tooltip: "Add",
      child: Icon(Icons.add),
      onPressed: (){
          Navigator.pushNamed(context, '/AddTodoPage');
      },
    ),
    );
  }
}
