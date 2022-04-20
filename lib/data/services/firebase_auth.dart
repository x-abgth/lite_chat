import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lite_chat/data/services/user_db.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Checks if user is signed in or not
  Stream<User?> checkAuthentication(BuildContext context) {
    return _auth.authStateChanges();
  }

  // // Sends email verification link
  // Future sendEmailVerification() async {
  //   if (_auth.currentUser != null)
  //     await _auth.currentUser!.sendEmailVerification();
  // }

  // // returns true/ false according email verification.
  // bool emailVerified() {
  //   reloadUser();
  //   return _auth.currentUser!.emailVerified;
  // }

  // // reloads user
  // Future reloadUser() async {
  //   try {
  //     await _auth.currentUser!.reload();
  //   } catch (e) {
  //     print("ERROR: $e");
  //   }
  // }

  // call this when new user is created
  Future createUser(String name, String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserDb(userId: _auth.currentUser?.uid ?? "")
          .updateUserData(displayName: name, emailId: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
          msg: "The provided email is already in use.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Registration failed. Please try again.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  // call this when user signing in using email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(
          msg: "No user found with this email.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      } else {
        Fluttertoast.showToast(
          msg: e.message ?? "Login failed. Please try again.",
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }
  }

  // call this when user forgot password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      return null;
    }
  }

  // call this when user logging out or signing out
  Future<bool> logout() async {
    try {
      _auth.signOut();
      return true;
    } on FirebaseAuthException {
      return false;
    }
  }
}
