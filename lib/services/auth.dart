import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService._();
  static final AuthService _service = AuthService._();
  factory AuthService() => _service;

  static AuthService get instance => _service;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> createUserWithEmailAndPassword({
    required String email,
    required String password
  }) async {
    try {
      print("createUserWithEmailAndPassword");
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
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
}

