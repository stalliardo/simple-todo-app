import 'package:bookclub/screens/root/root.dart';
import 'package:bookclub/states/currentUser.dart';
import 'package:bookclub/utils/ourtheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider<CurrentUser>(
    create: (context) => CurrentUser(),
    builder: (context, _) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // removes the debug overlay from the previewer
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
      home: MyRoot(),
    );
  }
}
