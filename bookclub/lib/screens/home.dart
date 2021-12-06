import 'package:bookclub/models/todoModel.dart';
import 'package:bookclub/services/auth.dart';
import 'package:bookclub/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth _auth = Provider.of<Auth>(context);

    TextEditingController _todoController = TextEditingController();
    TodoModel defaultTodo = TodoModel(value: "", id: "");
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView(
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              await Auth().signInWithEmailAndPassword("test2@gmail.com", "010101");
            },
            child: Text("Sign in"),
          ),
          ElevatedButton(
            onPressed: () {
              Auth().signOut();
            },
            child: Text("Sign out"),
          ),
          Text("You are currently: ${_auth.loginState == ApplicationLoginState.loggedIn ? 'logged in' : 'logged out'}"),
          SizedBox(
            height: 30,
          ),
          Text("Display todos if any exist..."),
          StreamProvider<List<TodoModel>>.value(
            value: MyDatabase().getTodos("AK6P8BJf0yaxYko5Uki6a43mTwD2"),
            initialData: [],
            child: Consumer<List<TodoModel>>(
              builder: (context, todoItem, _) => Column(
                children: [
                  for (var item in todoItem)
                    Text(
                      item.value.toString(),
                    )
                ],
              ),
            ),
          ),
          //TODO
          SizedBox(
            height: 40,
          ),
          Text("Enter new Todo here"),
          TextFormField(controller: _todoController),
          ElevatedButton(
            onPressed: () {},
            child: Text("Save Todo"),
          ),
          ElevatedButton(
            onPressed: () {
              print("/get test called");
              MyDatabase().getTodos("B5FzRY0FWKmSGz2EzZsL");
            },
            child: Text("get test Todos"),
          ),
        ],
      ),
    );
  }
}
