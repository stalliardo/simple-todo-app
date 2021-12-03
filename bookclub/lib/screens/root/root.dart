import 'package:bookclub/screens/home/home.dart';
import 'package:bookclub/screens/login/login.dart';
import 'package:bookclub/screens/group/nogroup/noGroup.dart';
import 'package:bookclub/screens/splashscreen/splashScreen.dart';
import 'package:bookclub/states/currentGroup.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLoader extends StatelessWidget {
  final AuthStatus? authStatus;
  ScreenLoader({required this.authStatus});

  @override
  Widget build(BuildContext context) {
    Widget screenToDisplay = Login();

    // this needs to refresh the currentUser state

    switch (authStatus!) {
      case AuthStatus.isLoggedOut:
        print("IsLoggedOut called");
        screenToDisplay = Login();
        break;
      case AuthStatus.unKnown:
        print("unknown called");
        screenToDisplay = SplashScreen();

        break;
      case AuthStatus.isInGroup:
        // Use changeNotifierProvider to provide changes of the state of the group to the only the homeScreen
        print("Is in group called");
        screenToDisplay = ChangeNotifierProvider<CurrentGroup>(
          create: (context) => CurrentGroup(),
          builder: (context, _) => HomeScreen(),
        );

        break;
      case AuthStatus.notInGroup:
        print("NotInGroup called");
        screenToDisplay = MyNoGroup();
        break;
    }

    return screenToDisplay;
  }
}

class MyRoot extends StatefulWidget {
  MyRoot({Key? key}) : super(key: key);

  @override
  _MyRootState createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<CurrentUser>(
          builder: (context, _user, _) => ScreenLoader(authStatus: _user.authStatus),
        ),
      ),
    );
  }
}
