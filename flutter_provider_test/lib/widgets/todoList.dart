import 'package:flutter/material.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:flutter_provider_test/widgets/todo_tile.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoData>(
      builder: (context, todoData, _) {
        return ListView.builder(
          itemBuilder: (context, index) {
            return TodoTile(
              todoData.getTodo(index),
              index,
            );
          },
          itemCount: Provider.of<TodoData>(context).todoCount,
          padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
        );
      },
    );
  }
}
