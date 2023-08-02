import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/app_user_state.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService._();
  static final AuthService _service = AuthService._();
  factory AuthService() => _service;

  static AuthService get instance => _service;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  AppUser emptyUser = AppUser.initial(false);

  Future<AppUser> createUserWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      print("createUserWithEmailAndPassword");
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      AppUser signedInUser =
          AppUser.fromJson(userCredential.user as Map<String, dynamic>);
      return signedInUser;
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
    return emptyUser;
  }

  Future<AppUser> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential? userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      AppUser signedInUser =
          AppUser.fromJson(userCredential.user as Map<String, dynamic>);
      return signedInUser;
    }
    return emptyUser;
  }

  Future<AppUser> signInWithGoogle() async {
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
        //this is coming through as a user even when we use the as
        AppUser signedInUser = AppUser(
            id: userCredential.user!.uid,
            isLoggedIn: true,
            displayName: userCredential.user!.displayName,
            email: userCredential.user!.email,
            friends: [],
            dismissed: []);
        return signedInUser;
      }
    } on FirebaseAuthException catch (e) {
      print("Sign in with Google failed.");
      print(e.message);
    } catch (e) {
      print(e.toString());
    }
    return emptyUser;
  }
}
