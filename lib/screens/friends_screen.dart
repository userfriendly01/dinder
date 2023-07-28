import 'package:dinder/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) => store.state.toMap(),
      builder: (context, state) {
        return Scaffold(
        bottomNavigationBar: BottomMenu(currentIndex: 1),
        body: Column(children: [
          Text('My FRIENDS are ${state['name']}')
        ]),
      );
      },
    );
  }
}