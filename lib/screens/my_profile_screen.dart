import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';


class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Map>(
      converter: (store) => store.state.toMap(),
      builder:(context, state) {
        return Scaffold(
        body: Container(
          padding: EdgeInsets.all(30),
        ),
        bottomNavigationBar: BottomMenu(currentIndex: 2),
      );
      },
    );
  }
}