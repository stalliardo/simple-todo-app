import 'package:bookclub/screens/login/localwidgets/loginForm.dart';
import 'package:bookclub/widgets/myContainer.dart';
import 'package:flutter/material.dart';

import 'localwidgets/signUpForm.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    BackButton(),
                  ],
                ),
                SignUpForm(),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
