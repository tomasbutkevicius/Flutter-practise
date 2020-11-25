import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/pages/addTodo.dart';
import 'package:flutter_provider_test/pages/todoList.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main(){
  Hive.registerAdapter(TodoAdapter());

  runApp(TodoApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "To-dos",
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => FutureBuilder(
            future: _initHive(),
            builder: (context, snapshot){
              if(snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text("Error establishing connection to hive"),
                    ),
                  );
                } else {
                  return TodoListPage();
                }
            } else
              return Scaffold();
            }
          ),
          "/AddTodoPage": (context) => AddTodoPage()
        },
      )
    );
  }
}
