import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService._();
  static final AuthService _service = AuthService._();
  factory AuthService() => _service;

  static AuthService get instance => _service;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      print("createUserWithEmailAndPassword");
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("HELLO????");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('WEAK PASSWORD LOSER');
      } else if (e.code == "email-already-in-use") {
        print(e);
      } else {
        print(e.message);
      }
    } catch (e) {
      print("non firebase exception ${e.toString()}");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
        'https://www.googleapis.com/auth/userinfo.email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ]);
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        print("LOGGED IN!!!!");
        print(userCredential.user);
        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      print("Sign in with Google failed.");
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
  }
}
