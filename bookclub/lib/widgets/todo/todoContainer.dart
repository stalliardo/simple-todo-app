import 'package:bookclub/models/todoModel.dart';
import 'package:bookclub/services/auth.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/widgets/todo/editTodoModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoContainer extends StatefulWidget {
  TodoContainer({Key? key}) : super(key: key);

  @override
  _TodoContainerState createState() => _TodoContainerState();
}

class _TodoContainerState extends State<TodoContainer> {
  TextEditingController _todoController = TextEditingController();
  String dropdownValue = "Uncategorized";
  String _todoFilter = "Urgent";

  @override
  void dispose() {
    super.dispose();

    _todoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Auth _auth = Provider.of<Auth>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: _todoController,
        ),
        DropdownButton<String>(
            value: dropdownValue,
            icon: Icon(Icons.arrow_downward),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
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
        ElevatedButton(
          onPressed: () async {
            if (_todoController.text.length > 1) {
              StatusCode _response = await MyDatabase().addTodo(_todoController.text, _auth.user!.uid!, dropdownValue);
              if (_response == StatusCode.ERROR) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("An error occured while adding the todo. Please try again"),
                  ),
                );
              } else {
                _todoController.clear();
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("You cannot save a todo that has no text"),
                ),
              );
            }
          },
          child: Text("Save Todo"),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          children: <Widget>[
            Text("Filter todos"),
            SizedBox(
              width: 40,
            ),
            DropdownButton<String>(
              value: _todoFilter,
              icon: Icon(Icons.arrow_downward),
              onChanged: (String? newValue) {
                setState(() {
                  _todoFilter = newValue!;
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
              }).toList(),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        StreamProvider<List<TodoModel>>.value(
          value: MyDatabase().getTodos(_auth.user!.uid),
          initialData: [],
          child: Consumer<List<TodoModel>>(
            builder: (context, _todoList, _) => Column(
              children: [
                // for (var todo in _todoList)
                // Padding(
                //   padding: EdgeInsets.symmetric(vertical: 6),
                //   child: Card(
                //     child: ListTile(
                //       tileColor: Colors.grey[100],
                //       title: Text(todo.value.toString()),
                //       subtitle: Text(
                //         todo.category,
                //         style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, height: 3),
                //       ),
                //       trailing: Icon(Icons.edit),
                //       onTap: () {
                //         showModalBottomSheet(
                //             context: context,
                //             builder: (context) => EditTodoModal(
                //                   todo: todo,
                //                   userId: _auth.user!.uid!,
                //                 ));
                //       },
                //     ),
                //   ),
                // )

                for (var todo in _todoList)
                  todo.category == _todoFilter
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 6),
                          child: Card(
                            child: ListTile(
                              tileColor: Colors.grey[100],
                              title: Text(todo.value.toString()),
                              subtitle: Text(
                                todo.category,
                                style: TextStyle(color: Colors.red[800], fontWeight: FontWeight.bold, height: 3),
                              ),
                              trailing: Icon(Icons.edit),
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) => EditTodoModal(
                                          todo: todo,
                                          userId: _auth.user!.uid!,
                                        ));
                              },
                            ),
                          ),
                        )
                      : SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


/// Filter todos, will display the categories plus an "All" filter
/// Will have to add the todos to an array then display urgent by default.
/// Will use the category as the filter. todoArray.map((e) => return e.category == "filterCategory"); 
/// Feel like this will work fine