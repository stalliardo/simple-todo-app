import 'package:bookclub/models/todoModel.dart';
import 'package:flutter/material.dart';

class EditTodoModal extends StatefulWidget {
  TodoModel todo;
  EditTodoModal({required this.todo});

  @override
  _EditTodoModalState createState() => _EditTodoModalState();
}

class _EditTodoModalState extends State<EditTodoModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.green[50],
      child: Column(
        children: <Widget>[
          Text("Todo = ${widget.todo.value}"),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Close"),
          )
        ],
      ),
    );
  }
}
