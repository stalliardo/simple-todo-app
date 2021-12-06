import 'package:bookclub/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

enum ApplicationLoginState { loggedIn, loggedOut, unknown }
enum StatusCode { ERROR, SUCCESS }

class Auth extends ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  MyUser? _user;

  MyUser? get user => _user;

  Auth() {
    print("init called");
    init();
  }

  Future<void> init() async {
    _auth.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        // TODO build the userModel
        _user = MyUser(uid: user.uid, email: user.email);
        print("user: ${user.uid}");
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  Future<StatusCode> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
      return StatusCode.ERROR;
    }

    notifyListeners();
    return StatusCode.SUCCESS;
  }

  Future<StatusCode> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return StatusCode.SUCCESS;
    } catch (e) {
      print("Error signing user in. Error: $e");
      return StatusCode.ERROR;
    }
  }
}
