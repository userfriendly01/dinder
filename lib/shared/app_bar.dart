import 'package:flutter/material.dart';
import 'package:dinder/screens/home_screen.dart';
import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';
import '../services/firestore.dart';
import '../services/auth.dart';

class DinderAppBar extends StatelessWidget implements PreferredSizeWidget {

  const DinderAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return AppBar(
          title: const Text("Dinder"),
          elevation: 3,
          actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logging out...'))
                  );
                  vm.logOut();
                },
              ),
            ],
        );
      });
    
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ViewModel {
  final void Function() logOut;
  static AuthService _authService = AuthService.instance;

  const _ViewModel({
    required this.logOut,
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService _firestoreService = FirestoreService.instance;

    return _ViewModel(
      logOut: () {
        _authService.signOut();
        store.dispatch(LogOutUser());
      },
    );
  }
}
