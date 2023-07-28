import 'package:dinder/screens/home_screen.dart';
import 'package:dinder/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/actions/general_actions.dart';
import 'package:dinder/models/app_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) => store.state.toMap(),
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text("SPASHY SPLASHY!"),
              Text('yo ${state['name']}'),
              Text('Is logged in??? ${state['isLoggedIn']}'),
              IconButton(onPressed: () {
                StoreProvider.of<AppState>(context)
                  .dispatch(UpdateNameAction('Kaleigh and Faith'));
              }, icon: Icon(Icons.cookie)),
              IconButton(onPressed: () {
                StoreProvider.of<AppState>(context)
                  .dispatch(UpdateIsLoggedIn(true));
              }, icon: Icon(Icons.login)),
            ],
          ),
      );
      },
    );
  }
}