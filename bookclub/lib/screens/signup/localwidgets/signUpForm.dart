import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/myContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  void _signUpUser(String email, String password, String fullName, BuildContext context) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);

    try {
      String _resultString = await _currentUser.registerUser(email, password, fullName);
      if (_resultString == "Success") {
        Navigator.pop(context);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return MyContainer(
        child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
          child: Text(
            "Sign Up",
            style: TextStyle(color: Theme.of(context).secondaryHeaderColor, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        TextFormField(
          controller: _fullNameController,
          decoration: InputDecoration(prefixIcon: Icon(Icons.person_outline), hintText: "Full Name"),
        ),
        SizedBox(
          height: 20,
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
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_outline),
            hintText: "Password",
          ),
          obscureText: true,
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(prefixIcon: Icon(Icons.lock_open), hintText: "Confirm Password"),
          obscureText: true,
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            print("Sign user up pressed!");
            if (_passwordController.text == _confirmPasswordController.text) {
              _signUpUser(_emailController.text, _passwordController.text, _fullNameController.text, context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Passwords do not match!"),
                ),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 76),
            child: Text("Sign Up"),
          ),
        ),
      ],
    ));
  }
}
