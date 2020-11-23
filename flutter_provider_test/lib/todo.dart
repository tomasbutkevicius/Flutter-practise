import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject with ChangeNotifier {
  @HiveField(0)
  List<String> words;

  @HiveField(1)
  bool done;

  Todo() {
    this.words = [""];
    this.done = false;
  }

  @HiveField(2)
  void add() {
    words.add("test");
    notifyListeners();
  }
}
