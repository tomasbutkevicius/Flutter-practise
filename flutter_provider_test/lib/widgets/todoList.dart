import 'package:flutter/material.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:flutter_provider_test/widgets/todoTile.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index){
      return TodoTile(
        tileIndex: index,
      );
    },
      itemCount: Provider.of<TodoData>(context).todoCount,
      padding: EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 4.0),
    );
  }
}
