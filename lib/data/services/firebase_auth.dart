import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  checkAuthentication(BuildContext context) {
    print("**************${_auth.currentUser}************");
    return _auth.currentUser;
  }

  // call this when new user is created
  Future createUser(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Warning!!!" + result.user!.uid);
      return result.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print("The provided email is already used");
      }
    }
  }

  // call this when user signing in using email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user!.uid;
    } on FirebaseAuthException {
      return null;
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
