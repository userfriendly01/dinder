import 'dart:async';

import 'package:dinder/actions/app_user_actions.dart';
import 'package:dinder/main.dart';
import 'package:dinder/models/app_state.dart';
import 'package:dinder/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../services/auth.dart';
import '../models/app_user_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final AuthService _authService = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    print(_authService.currentUser);
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(children: [
            Text("LOGIN"),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    _onSubmitRegisterButton(context, "Register");
                  },
                  child: Text('Register')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _onSubmitRegisterButton(context, "Login");
                  // Todo: Still need to implement this...
                  // StoreProvider.of<AppState>(context)
                  //     .dispatch(UpdateIsLoggedIn(true));
                },
                child: Text('Login with email and password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  _onLoginWithGoogle(context, vm);
                },
                child: Text('Login with Google'),
              ),
            )
          ]),
        ));
      },
    );
  }

  _onSubmitRegisterButton(context, String loginType) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Creating User...")));
    try {
      User? user;
      print('authservice ${_authService.toString()}');
      if (loginType == "Register") {
        user = await _authService.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      } else {
        user = await _authService.signInWithEmailAndPassword(email: email.text, password: password.text);
      }
      print(user);
      if (user != null) {
        // TODO: make a database entry?
        // todo convert
        // Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print("bummer");
      }
    } catch (e) {
      print('CATCH');
      print(e);
    }
    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  _onLoginWithGoogle(context, _ViewModel vm) async {
        ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Creating User...")));
    try {
      print('authservice ${_authService.toString()}');
      final User? user = await _authService.signInWithGoogle();
      print(user);
      if (user != null) {
        print('user.uid ${user.uid}');
        // try to fetch user from db, if not there, add them
        AppUser newUser = AppUser(id: user.uid, isLoggedIn: true, displayName: user.displayName, email: user.email, friends: [], dismissed: []);
        vm.fetchUser(user.uid, newUser);
        // AppUser appUser = AppUser(id: user.uid, isLoggedIn: true, email: user.email, displayName: user.displayName, friends: [], dismissed: []);
        // vm.loginUser(appUser);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      } else {
        print("bummer");
      }
    } catch (e) {
      print('CATCH');
      print(e);
    }
  }

}

class _ViewModel {
  final String? displayName;
  final void Function(AppUser user) loginUser;
  final void Function() registerUser;
  final void Function(String id, AppUser authUser) fetchUser;
  //dont know if we'll use this and add a reducer function or just Meat()
  //May want to read into forms in flutter a bit

  static FirestoreService _firestoreService = FirestoreService.instance;


  _ViewModel({
    required this.displayName,
    required this.registerUser,
    required this.loginUser,
    required this.fetchUser
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
        displayName: store.state.userState.displayName,
        loginUser: (AppUser user) => store.dispatch(LogInUser(user)),
        fetchUser: (String id, AppUser authUser) {
          Stream<AppUser> user = _firestoreService.getUser(id);
          if (user == null) {
            _firestoreService.createUser(id, {})
          }
        },
        registerUser: () {
          //Kaleigh Note 16 - We should revisit the auth and understand how to update the state
          //through the reducer/in the correct way and tie it to this View Model

        });
  }
}
