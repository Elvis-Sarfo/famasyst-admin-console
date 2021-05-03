import 'package:farmasyst_admin_console/utils/helper_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  static dynamic loginWithEmailAndPassword(
      String email, String password) async {
    var result;
    try {
      result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        result = 'User Not Found' + e.message;
      } else if (e.code == 'user-disabled') {
        result = 'User Disabled';
      } else if (e.code == 'invalid-email') {
        result = 'Invalid Email';
      } else if (e.code == 'wrong-password') {
        result = 'Wrong Password';
      }
    }
    return result;
  }

  // Login method
  // Return **UserCredential**
  static Future<dynamic> login({String email, String password}) async {
    var result;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      result = userCredential;
    } on FirebaseAuthException catch (e) {
      var error;
      if (e.code == 'user-not-found') {
        error = {'title': 'User Not Found', 'messgae': e.message};
      } else if (e.code == 'user-disabled') {
        error = {'title': 'User Disabled', 'messgae': e.message};
      } else if (e.code == 'invalid-email') {
        error = {'title': 'Invalid Email', 'messgae': e.message};
      } else if (e.code == 'wrong-password') {
        error = {'title': 'Wrong Password', 'messgae': e.message};
      }
      result = error;
    }
    print('from method' + result);
    return result;
  }

  static Future<dynamic> sinupWithPhone(String phoneNum) async {
    return await FirebaseAuth.instance.signInWithPhoneNumber(
      validatePhoneNum(phoneNum),
    );
  }
}
