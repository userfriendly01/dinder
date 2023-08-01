import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../shared/bottom_menu.dart';
import '../actions/meat_actions.dart';
import '../models/app_state.dart';
import '../models/meat_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        if (vm.displayName == "Navigate me to the friends page!") {
          //Kaleigh Note 18 - This is what we need to make sure we can navigate in conditionals.. it waits for other things to finish painting so we dont
          //get the error that other things are already being rendered
          WidgetsBinding.instance.addPostFrameCallback((_) {
            vm.navigateToFriendsPage(context);
          });
        }
        ;
        return Scaffold(
          bottomNavigationBar: BottomMenu(currentIndex: 0),
          floatingActionButton: IconButton(
            icon: Icon(Icons.fastfood_outlined),
            onPressed: () {
              // print();
            },
          ),
          body: Column(
            children: [
              Text("HOME!"),
              Text('yo ${vm.displayName}'),
              IconButton(
                  tooltip: "Press me to go to the friends page",
                  onPressed: () {
                    //Kaleigh Note 17 - adding a state change here to show you Note 18!
                    vm.updateDisplayName("Navigate me to the friends page!");
                  },
                  icon: Icon(Icons.cookie))
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final String? displayName;
  final void Function(Meat newMeat) createMeat;
  final void Function(String newName) updateDisplayName;
  final void Function(BuildContext context) navigateToFriendsPage;

  //dont know if we'll use this and add a reducer function or just Meat()
  //May want to read into forms in flutter a bit

  const _ViewModel({
    required this.displayName,
    required this.createMeat,
    required this.updateDisplayName,
    required this.navigateToFriendsPage,
  });

  static fromStore(Store<AppState> store) {
    return _ViewModel(
        displayName: store.state.userState.displayName,
        createMeat: (Meat meat) => store.dispatch(CreateMeat(meat)),
        updateDisplayName: (String newName) =>
            store.dispatch(UpdateDisplayName(newName)),
        navigateToFriendsPage: (BuildContext context) {
          Navigator.pushNamed(context, '/friends');
        });
  }
}
