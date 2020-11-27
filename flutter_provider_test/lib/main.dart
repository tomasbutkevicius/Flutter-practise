import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/pages/addTodo.dart';
import 'package:flutter_provider_test/pages/todoList.dart';
import 'package:flutter_provider_test/pages/todoView.dart';
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

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Todo _selectedTodo;
  bool _selectedAddTodo = false;

  void _handleTodoTapped(BuildContext context, Todo todo) {
    Provider.of<TodoData>(context, listen: false).setActiveTodo(todo.key);
  }

  void _handleAddTodoTapped(bool selectedAddBtn) {
    setState(() {
      _selectedAddTodo = selectedAddBtn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "To-dos",
        theme: ThemeData(primaryColor: Colors.lightBlueAccent),
        initialRoute: "/",
        // routes:
        home: Consumer<TodoData>(
          builder: (context, todoData, _) {
            return Navigator(
              pages: [
                MaterialPage(
                  child: TodoListPage(
                      onTodoTap: (Todo todo) => _handleTodoTapped(context, todo),
                      onAddTodoTap: _handleAddTodoTapped),
                ),
                if(todoData.getActiveTodo() != null)
                  MaterialPage(
                    child: TodoView(),
                  )
              ],
              onPopPage: (route, result) {
                if (!route.didPop(result)) return false;


                Provider.of<TodoData>(context, listen: false).disableActiveTodo();
                return true;
              },
            );
          },
        ),
      ),
    );
  }
}
