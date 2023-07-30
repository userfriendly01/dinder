import 'package:dinder/actions/user_actions.dart';
import 'package:dinder/models/app_state.dart';
import 'package:dinder/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
                    _onSubmitLoginButton(context);
                  },
                  child: Text('Register')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  StoreProvider.of<AppState>(context)
                      .dispatch(UpdateIsLoggedIn(true));
                },
                child: Text('Login'),
              ),
            )
          ]),
        ));
      },
    );
  }

  _onSubmitLoginButton(context) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Creating User...")));
    try {
      print('authservice ${_authService.toString()}');
      final User? user = await _authService.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(user);
      if (user != null) {
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
}

class _ViewModel {
  final String? displayName;
  final void Function() registerUser;
  //dont know if we'll use this and add a reducer function or just Meat()
  //May want to read into forms in flutter a bit

  const _ViewModel({
    required this.displayName,
    required this.registerUser,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
        displayName: store.state.userState.displayName,
        registerUser: () {
          //Kaleigh Note 16 - We should revisit the auth and understand how to update the state
          //through the reducer/in the correct way and tie it to this View Model
        });
  }
}
