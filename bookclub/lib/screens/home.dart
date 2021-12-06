import 'package:bookclub/models/todoModel.dart';
import 'package:bookclub/screens/logIn.dart';
import 'package:bookclub/screens/root.dart';
import 'package:bookclub/services/auth.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/widgets/todo/todoContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth _auth = Provider.of<Auth>(context);

    TextEditingController _todoController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              // TODO log in/log out

              if (_auth.loginState == ApplicationLoginState.loggedOut) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LogInForm(),
                  ),
                );
              } else {
                // Log user out...
                StatusCode response = await _auth.signOut();
                if (response == StatusCode.SUCCESS) {
                  // Signed out successfully now put them back to the ..... root widget
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Root()), (route) => false);
                }
              }
            },
            icon: Icon(_auth.loginState == ApplicationLoginState.loggedIn ? Icons.login : Icons.login),
            tooltip: _auth.loginState == ApplicationLoginState.loggedIn ? "Log out" : "Log in",
          ),
          _auth.loginState == ApplicationLoginState.loggedOut
              ? IconButton(
                  onPressed: () {
                    // TODO Register
                  },
                  icon: Icon(
                    Icons.app_registration_rounded,
                  ),
                  tooltip: "Register",
                )
              : Text(""),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          TodoContainer()
        ],
      ),
    );
  }
}
