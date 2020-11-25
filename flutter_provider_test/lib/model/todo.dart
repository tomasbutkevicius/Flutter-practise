import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String taskDescription;

  @HiveField(1)
  final bool isComplete;

  Todo({@required this.taskDescription, this.isComplete});

}
