import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/pages/todoView.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:provider/provider.dart';

class TodoTile extends StatelessWidget {
  final Todo currentTodo;
  final int tileIndex;

  const TodoTile(this.currentTodo, this.tileIndex);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: tileIndex % 2 == 0 ? Colors.black87 : Colors.black54,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightBlueAccent,
          child: currentTodo.isComplete == true
              ? Text("+",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold))
              : Text("-",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ),
        title: Text(currentTodo.taskDescription?? "",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)
        ),
        onTap: (){

          Provider.of<TodoData>(context, listen: false).setActiveTodo(currentTodo.key);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) {
                    return TodoView();
                  }
              )
          );

        },
      ),
    );
  }
}
