import 'package:dinder/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) => store.state.toMap(),
      builder: (context, state) {
        return Scaffold(
          body: Column(
            children: [
              Text("LOGIN"),
              ElevatedButton(
                onPressed: () {
                  print('you clicked register');
                }, 
                child: Text('Register')
              ),
              ElevatedButton(
                onPressed: () {
                  print('you clicked register');
                },
                child: Text('Login'),
              )
            ]
          )
        );
      },
    );
  }
}