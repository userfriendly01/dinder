import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';

import '../services/auth.dart';

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
              child: ElevatedButton(
                onPressed: vm.logOut,
                child: const Text("Log Out"),
              )),
          bottomNavigationBar: BottomMenu(currentIndex: 2),
        );
      },
    );
  }
}

class _ViewModel {
  final void Function() logOut;
  static AuthService _authService = AuthService.instance;

  const _ViewModel({required this.logOut});

  static fromStore(Store<AppState> store) {
    return _ViewModel(
      logOut: () {
        _authService.signOut();
        store.dispatch(LogOutUser());
      },
    );
  }
}
