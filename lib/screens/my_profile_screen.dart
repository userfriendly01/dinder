import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
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

class _ViewModel {
  const _ViewModel();

  static fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
