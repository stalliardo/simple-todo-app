import 'package:bookclub/models/users.dart';
import 'package:bookclub/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/cupertino.dart';

enum AuthStatus { isLoggedOut, unKnown, isInGroup, notInGroup }

class CurrentUser extends ChangeNotifier {
  MyUser? _currentUser = MyUser();
  MyUser get getCurrentUser => _currentUser!;

  AuthStatus _authStatus = AuthStatus.isLoggedOut;
  AuthStatus get authStatus => _authStatus;

  FirebaseAuth? _auth;

  CurrentUser() {
    print(("CurrentUser constructor called"));
    init();
  }

  Future<void> init() async {
    print("Currentuser init called");
    _authStatus = AuthStatus.unKnown;
    _auth = FirebaseAuth.instance;
    _auth!.userChanges().listen((user) async {
      if (user != null) {
        _currentUser = await MyDatabase().getUserInfo(user.uid);
        print("CurrentUser groupId = : ${_currentUser!.groupId}");
        if (_currentUser!.groupId == null) {
          _authStatus = AuthStatus.notInGroup; // logged in but not in group
        } else {
          _authStatus = AuthStatus.isInGroup;
        }

        MyDatabase().getUserInfo(user.uid);
      } else {
        _currentUser!.uid = null;
        _currentUser!.email = null;
        _authStatus = AuthStatus.isLoggedOut;
      }
      print("notify listeners called at the bottom of inti");
      notifyListeners();
    });
  }

  Future<String> registerUser(String email, String password, String fullName) async {
    String returnValue = "error";
    MyUser _user = MyUser();
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      // build user for adding to database
      _user.uid = userCredential.user!.uid;
      _user.email = email;
      _user.fullName = fullName;

      String returnString = await MyDatabase().createUser(_user);

      if (returnString != "Success") {
        returnValue = "error";
      }

      returnValue = "Success";
    } catch (e) {
      returnValue = "error";
    }
    notifyListeners();

    return returnValue;
  }

  Future<String> logInUserWithEmailAndPassword(String email, String password) async {
    String returnValue = "error";

    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      _currentUser = await MyDatabase().getUserInfo(credential.user!.uid);

      if (_currentUser != null) {
        returnValue = "Success";
      }
    } catch (e) {
      print("Error logging the user in. Error: $e");
      returnValue = "error";
    }
    notifyListeners();

    return returnValue;
  }

  Future<String> signUserOut() async {
    String returnValue = "error";
    try {
      await FirebaseAuth.instance.signOut();
      _currentUser = MyUser();
      _authStatus = AuthStatus.isLoggedOut;
      returnValue = "Success";
    } catch (e) {
      returnValue = "error";
    }

    return returnValue;
  }
}
