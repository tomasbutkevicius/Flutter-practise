import 'package:flutter/cupertino.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/utils.dart';
import 'package:hive/hive.dart';

class TodoData extends ChangeNotifier {
  var box = Hive.box<Todo>("todoBox");

  List<Todo> _todo = [];
  Todo _activeTodo;

  TodoData() {
    _todo = box.values.toList();
    notifyListeners();
  }

  Todo getTodo(int index){
    return _todo[index];
  }

  void addTodo(Todo todo) async{
    await box.add(todo);
    _todo = box.values.toList();

    notifyListeners();
  }

  void deleteTodo(int key) async {
    await box.delete(key);

    _todo = box.values.toList();

    Log.info("Deleted member with key " + key.toString());

    notifyListeners();
  }

  void editTodo({Todo todo, int todoKey}) async {
    await box.put(todoKey, todo);

    _todo = box.values.toList();
    _activeTodo = box.get(todoKey);

    Log.info("Edited Todo");

    notifyListeners();
  }

  void setActiveTodo(key) async {
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