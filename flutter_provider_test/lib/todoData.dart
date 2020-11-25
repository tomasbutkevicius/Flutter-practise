import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/utils.dart';
import 'package:hive/hive.dart';

class TodoData extends ChangeNotifier {
  static const String _boxName = "todoBox";

  List<Todo> _todo = [];

  Todo _activeTodo;

  void getTodos() async {
    var box = await Hive.openBox<Todo>(_boxName);

    _todo = box.values.toList();

    notifyListeners();
  }

  Todo getTodo(index){
    return _todo[index];
  }

  void addTodo(Todo todo) async{
    var box = await Hive.openBox<Todo>(_boxName);

    await box.add(todo);

    _todo = box.values.toList();

    notifyListeners();
  }

  void deleteTodo(key) async {
    var box = await Hive.openBox<Todo>(_boxName);

    await box.delete(key);

    _todo = box.values.toList();

    Log.info("Deleted member with key " + key.toString());
  }

  void editTodo({Todo todo, int todoKey}) async {
    var box = await Hive.openBox<Todo>(_boxName);

    await box.put(todoKey, todo);

    _todo = box.values.toList();

    _activeTodo = box.get(todoKey);

    Log.info("Edited Todo");

    notifyListeners();
  }

  void setActiveTodo(key) async {
    var box = await Hive.openBox<Todo>(_boxName);

    _activeTodo = box.get(key);

    notifyListeners();
  }

  Todo getActiveTodo(){
    return _activeTodo;
  }

  int get todoCount{
    return _todo.length;
  }
}