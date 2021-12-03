import 'package:bookclub/screens/addBook/addBook.dart';
import 'package:bookclub/screens/group/nogroup/noGroup.dart';
import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/states/currentGroup.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/widgets/myContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init state called");
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    CurrentGroup _currentGroup = Provider.of<CurrentGroup>(context, listen: false);
    _currentGroup.updateStateFromDatabase(_currentUser.getCurrentUser.groupId);
  }

  void _signOut(BuildContext context) async {
    // TODO sign user out
    String resultString = await Provider.of<CurrentUser>(context, listen: false).signUserOut();
    // Not actually needed as the consumer in the root class watches the value of the currentUser.isLogged in property
    // THis is only used here to remove all the screens on the stack
    if (resultString == "Success") {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyRoot()), (route) => false);
    }
  }

  void _goToAddBook(BuildContext context) {
    CurrentGroup _currentGroup = Provider.of<CurrentGroup>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddBook(
          onGroupCreation: false,
          groupName: _currentGroup.getCurrentGroup?.name,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: MyContainer(
              child: Consumer<CurrentGroup>(
                builder: (context, _currentGroup, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _currentGroup.getCurrentBook?.name ?? "Loading...",
                      style: TextStyle(fontSize: 25, color: Colors.grey[600]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Text(
                            "Due in:",
                            style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                          ),
                          Expanded(
                            child: Text(
                              _currentGroup.getCurrentGroup?.currentBookDueDate?.toDate().toString() ?? "Loading...",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Finished Book",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: MyContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Next book revealed in:",
                    style: TextStyle(fontSize: 25, color: Colors.grey[600]),
                  ),
                  Text(
                    "22 Hours",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: ElevatedButton(
              child: Text(
                "Book Club History",
              ),
              onPressed: () async {
                _goToAddBook(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: ElevatedButton(
              child: Text("Sign out"),
              onPressed: () async {
                _signOut(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
