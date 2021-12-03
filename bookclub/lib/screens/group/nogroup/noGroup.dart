import 'package:bookclub/screens/group/createGroup/createGroup.dart';
import 'package:bookclub/screens/group/joinGroup/joinGroup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNoGroup extends StatelessWidget {
  const MyNoGroup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _goToJoin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => JoinGroup(),
        ),
      );
    }

    void _goToCreate() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CreateGroup(),
        ),
      );
    }

    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
      children: <Widget>[
        Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Container(
              height: 200,
              child: Image.asset("assets/book.png"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Welcome to Stalliardo's book club",
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Since you are not in a club, you can select either to join a club " + "or create your own club.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      _goToCreate();
                    },
                    child: Text("Create"),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.fromLTRB(40, 10, 40, 10)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _goToJoin();
                    },
                    child: Text("Join"),
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.fromLTRB(40, 10, 40, 10)),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    ));
  }
}
