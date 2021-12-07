import 'package:bookclub/models/todoModel.dart';
import 'package:bookclub/services/auth.dart';
import 'package:bookclub/services/database.dart';
import 'package:flutter/material.dart';

class EditTodoModal extends StatefulWidget {
  TodoModel todo;
  String userId;
  EditTodoModal({required this.todo, required this.userId});

  @override
  _EditTodoModalState createState() => _EditTodoModalState();
}

class _EditTodoModalState extends State<EditTodoModal> {
  String? _dropDownValue;
  String? _originalDropDownValue;

  String? _originalTodoValue;
  TextEditingController? _todoController;

  String _errorText = "";

  @override
  void initState() {
    super.initState();
    _dropDownValue = widget.todo.category;
    _originalTodoValue = widget.todo.value;
    _todoController = TextEditingController(text: widget.todo.value);
    _originalDropDownValue = widget.todo.category;
  }

  @override
  void dispose() {
    super.dispose();

    _todoController?.dispose();
  }

  void _saveTodo(String todoValue, String category, String todoId) async {
    // return a status code from the database
    StatusCode _response = await MyDatabase().updateTodo(todoValue, category, widget.userId, todoId);
    if (_response == StatusCode.SUCCESS) {
      Navigator.pop(context);
    } else {
      setState(() {
        _errorText = "There was an error updating the todo.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      height: 260,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _todoController,
            onChanged: (value) {
              if (_errorText != "") {
                setState(() {
                  _errorText = "";
                });
              }
            },
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
              value: _dropDownValue,
              icon: Icon(Icons.arrow_downward),
              onChanged: (String? newValue) {
                setState(() {
                  _dropDownValue = newValue!;
                  if (_errorText != "") {
                    _errorText = "";
                  }
                });
              },
              style: TextStyle(
                color: Colors.deepPurpleAccent,
              ),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              items: <String>["Urgent", "Doing", "Done", "Low Priority", "Uncategorized"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList()),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_originalTodoValue != _todoController?.text || _originalDropDownValue != _dropDownValue) {
                      print("if called");
                      _saveTodo(_todoController!.text, _dropDownValue!, widget.todo.id);

                      //TODO call .pop
                    } else {
                      print("else caleld");
                      setState(() {
                        _errorText = "Cannot save until changes have been made";
                      });
                    }
                  },
                  child: Text("Update"),
                ),
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            _errorText,
            style: TextStyle(color: Colors.red[800]),
          ),
        ],
      ),
    );
  }
}
