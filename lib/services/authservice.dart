// ignore_for_file: non_constant_identifier_names, body_might_complete_normally_nullable, prefer_const_constructors, unused_local_variable, use_build_context_synchronously, await_only_futures

//import 'dart:math';

//import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_core/firebase_core.dart';

class AuthServic {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // register code
  Future<User?> Register(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

// LOGIN code
  Future<User?> Login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text('wrong info')));
    }
  }

  Future Logout() async {
    await firebaseAuth.signOut();
  }

  // google sign up
  Future<User?> signInGoogle(BuildContext context) async {
// trigger the pop up sign in
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        //obtain the details from google

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        // create new credentials
        final Credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        // return data into firestore
        UserCredential userCredential =
            await firebaseAuth.signInWithCredential(Credential);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
