import 'package:bookclub/screens/root.dart';
import 'package:bookclub/services/auth.dart';
import 'package:flutter/material.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 30),
        child: Center(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                    ),
                    hintText: "Email Address"),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                    icon: Icon(
                      Icons.password,
                    ),
                    hintText: "Email Address"),
                obscureText: true,
              ),
              ElevatedButton(
                  onPressed: () async {
                    StatusCode _response = await Auth().signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                    if (_response == StatusCode.SUCCESS) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Root()), (route) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("An error occured while signing you in. Please try again.")),
                      );
                    }
                  },
                  child: Text("Log In"))
            ],
          ),
        ),
      ),
    );
  }
}
