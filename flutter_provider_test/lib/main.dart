import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/pages/addTodo.dart';
import 'package:flutter_provider_test/pages/todoList.dart';
import 'package:flutter_provider_test/todoData.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  Hive.registerAdapter(TodoAdapter());
  await Hive.initFlutter();
  await Hive.openBox<Todo>("todoBox");
  runApp(TodoApp());
}

Future _initHive() async {
  var dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
}

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    "/": (context) => TodoListPage(),
    "/AddTodoPage": (context) => AddTodoPage()
  };
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
        routes: Routes.routes,
      )
    );
  }
}
