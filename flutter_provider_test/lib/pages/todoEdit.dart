import 'package:flutter/material.dart';
import 'package:flutter_provider_test/model/todo.dart';
import 'package:flutter_provider_test/widgets/toast.dart';
import 'package:provider/provider.dart';

import '../todoData.dart';

class TodoEditPage extends StatefulWidget {
  final Todo currentTodo;

  const TodoEditPage({@required this.currentTodo});


  @override
  _TodoEditPageState createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  String newTaskDescription;
  bool newIsCompleted;

  void _editTodo(context) {
    if (newTaskDescription == null) {
      toastWidget("Give task a description");
      return;
    }
    if (newTaskDescription.length < 2) {
      toastWidget("Description must be longer text");
      return;
    }

    Provider.of<TodoData>(context, listen: false).editTodo(
        todo: Todo(taskDescription: newTaskDescription,
            isComplete: newIsCompleted ?? false),
        todoKey: widget.currentTodo.key
    );

    Navigator.pop(context);
  }

  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text = widget.currentTodo.taskDescription;
    newTaskDescription = widget.currentTodo.taskDescription;

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 16.0,
        title: Text("Edit todo",
          style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
              iconSize: 24.0,
              color: Colors.blue,
              tooltip: "Save",
              onPressed: () {
                _editTodo(context);
              })
        ],
      ),
      body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                      hintText: "Description"
                  ),
                  onChanged: (v) {
                    setState(() {
                      newTaskDescription = v;
                    });
                  },
                ),
                Row(
                  children: <Widget>[
                    Text("Is complete", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0), ),
                    Switch(activeTrackColor: Colors.black, activeColor: Colors.blue, onChanged: (v){
                      setState(() {
                        newIsCompleted = v;
                      });
                    },
                      value: newIsCompleted ?? false,
                    )
                  ],
                )
              ],
            ),
          )
      ),
    );
  }
}
