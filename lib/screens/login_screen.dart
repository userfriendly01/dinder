import 'package:dinder/actions/general_actions.dart';
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
    return StoreConnector<AppState, Map>(
      converter: (store) => store.state.toMap(),
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(48.0),
            child: Column(
              children: [
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
                    child: Text('Register')
                  ),
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
              ]
            ),
          )
        );
      },
    );
  }

  _onSubmitLoginButton(context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Creating User..."))
    );
    try {
      print('authservice ${_authService.toString()}');
      final User? user = await _authService.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text
      );
      print(user);
      if (user != null) {
        // Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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