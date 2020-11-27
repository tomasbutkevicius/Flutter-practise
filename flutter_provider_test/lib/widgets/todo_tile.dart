import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/pages/todoView.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:provider/provider.dart';

class TodoTile extends StatelessWidget {
  final ValueChanged<Todo> onTap;
  final Todo currentTodo;
  final int tileIndex;

  const TodoTile(this.currentTodo, this.tileIndex, this.onTap);

  @override
  Widget build(BuildContext context) {
    print('build todo tile: ${currentTodo.key}');
    return Container(
      decoration: BoxDecoration(
        color: tileIndex % 2 == 0 ? Colors.grey[200] : Colors.white70,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: tileIndex % 2 == 0 ? Colors.grey[200] : Colors.white70,
          child: currentTodo.isComplete == true
              ? Text("+",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold))
              : Text("-",
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold)),
        ),
        title: Text(currentTodo.taskDescription?? "",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)
        ),
        onTap: (){
          //
          print('Tile on tap: START');
          Provider.of<TodoData>(context, listen: false).setActiveTodo(currentTodo.key);
          onTap(currentTodo);
          print('Tile on tap: END');
          //
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) {
          //           return TodoView();
          //         }
          //     )
          // );

        },
      ),
    );
  }
}
