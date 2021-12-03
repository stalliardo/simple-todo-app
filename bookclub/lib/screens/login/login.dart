import 'package:bookclub/screens/login/localwidgets/loginForm.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Image.asset("assets/book.png"),
                ),
                SizedBox(
                  height: 20,
                ),
                LoginForm()
              ],
            ),
          ),
        ],
      )),
    );
  }
}
