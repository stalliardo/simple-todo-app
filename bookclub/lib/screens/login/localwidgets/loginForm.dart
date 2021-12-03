import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/screens/signup/signup.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/myContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _logUserIn(String email, String password, BuildContext context) async {
    CurrentUser _user = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString = await _user.logInUserWithEmailAndPassword(email, password);
      if (_returnString == "Success") {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyRoot()), (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error signing in"),
          ),
        );
      }
    } catch (e) {
      print("error signing user in. Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
        child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Text(
            "Log In",
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: _emailController,
          decoration: InputDecoration(prefixIcon: Icon(Icons.alternate_email_rounded), hintText: "Email"),
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
          obscureText: true,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            _logUserIn(_emailController.text, _passwordController.text, context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 76),
            child: Text("Log in"),
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
            child: Text("Don't have an account? Sign up here"))
      ],
    ));
  }
}
