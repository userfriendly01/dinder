import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/shared/app_bar.dart';
import 'package:dinder/models/app_state.dart';
import '../services/firestore.dart';
import '../services/auth.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final TextEditingController displayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          appBar: const DinderAppBar(),
          body: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Text("${vm.displayName} Profile!", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  TextField(
                    controller: displayNameController,
                    decoration: const InputDecoration( hintText: "Display Name"),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  ElevatedButton(onPressed: () {
                    vm.updateDisplayName(displayNameController.text);
                    }, child: const Text("Save")),
                ],
              ),
              ),
          bottomNavigationBar: BottomMenu(currentIndex: 2),
        );
      },
    );
  }
}

class _ViewModel {
  final void Function() logOut;
  final void Function(String displayName) updateDisplayName;
  final String? displayName;
  static AuthService _authService = AuthService.instance;

  const _ViewModel({
    required this.logOut,
    required this.updateDisplayName,
    required this.displayName
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService _firestoreService = FirestoreService.instance;

    return _ViewModel(
      displayName: store.state.userState.displayName != "" ? "${store.state.userState.displayName}'s" : "My",
      logOut: () {
        _authService.signOut();
        store.dispatch(LogOutUser());
      },
      updateDisplayName: (String displayName) async {
        await _firestoreService.updateDisplayName(store.state.userState.id, displayName);
        store.dispatch(UpdateDisplayName(displayName));
      }
    );
  }
}
