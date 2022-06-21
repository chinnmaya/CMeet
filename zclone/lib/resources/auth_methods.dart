import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zclone/screens/sign_in.dart';

import '/screens/home_screen.dart';
import '/utils/utils.dart';

class AuthMethods {
  bool isusercreate = false;
  bool res = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();
  User get user => _auth.currentUser!;

  //TextEditingController email;
  //TextEditingController password;
  // AuthMethods(this.email, this.password);
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<bool> signInWithoogle(BuildContext context,
      TextEditingController email, TextEditingController password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
              email: email.text, password: password.text);

      User? user = userCredential.user;

      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set({
            'uid': user.uid,
          });
        }
      }
      return res = true;
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return res = false;
    }
  }

  Future<bool> createuser(
      BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder) => signin()), (route) => false);
      return isusercreate = true;
    } catch (e) {
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return isusercreate = false;
    }
  }

  void signOut(BuildContext context) async {
    try {
      _auth.signOut();
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (builder) => signin()), (route) => false);
    } catch (e) {
      print(e);
    }
  }
}
