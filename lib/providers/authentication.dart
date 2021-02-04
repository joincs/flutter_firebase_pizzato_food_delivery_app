import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends ChangeNotifier {
  dynamic errorMessage = '';
  dynamic get getErrorMessage => errorMessage;
  String uid, userEamil;
  String get getUid => uid;
  String get getUserEmail => userEamil;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future loginIntoAccount(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user;
      uid = user.uid;
      userEamil = user.email;
      sharedPreferences.setString('uid', uid);
      sharedPreferences.setString('useremail', userEamil);
      notifyListeners();
    } catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User Not Found';
          break;
        case 'wrong-password':
          errorMessage = 'Oops, Wrong Password';
          break;
        case 'invalid-email':
          errorMessage = "Sorry invalid email";
          break;
      }
    }
  }

  Future createNewAccount(String email, String password) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();

      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User user = userCredential.user;
      uid = user.uid;
      userEamil = user.email;
      sharedPreferences.setString('uid', uid);
      sharedPreferences.setString('useremail', userEamil);
      notifyListeners();
    } catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          errorMessage = 'Email Already in use';
          break;
        case 'invalid-email':
          errorMessage = 'Sorry, Invalid email';
          break;
      }
    }
  }
}
