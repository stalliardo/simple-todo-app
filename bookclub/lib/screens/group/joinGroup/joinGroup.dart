import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/services/database.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/myContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinGroup extends StatefulWidget {
  JoinGroup({Key? key}) : super(key: key);

  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    StatusCode _statusCode = await MyDatabase().joinGroup(groupId, _currentUser.getCurrentUser.uid!);

    if (_statusCode == StatusCode.SUCCESS) {
      // Passed to the root widget as that decides what screen/widget to display.
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyRoot()), (route) => false);
    }
  }

  TextEditingController _groupIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Join Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            MyContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupIdController,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.group), hintText: "Group Name"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _joinGroup(context, _groupIdController.text);
                    },
                    child: Text(
                      "Join",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
