import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/shared/app_bar.dart';
import '../services/firestore.dart';
import '../shared/bottom_menu.dart';
import '../actions/meat_actions.dart';
import '../models/app_state.dart';
import '../models/meat_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      // onInitialBuild: (viewModel) {
      //   viewModel.fetchActiveMeats();
      // },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        // * Example of WidgetsBinding
        // if (vm.displayName == "Navigate me to the friends page!") {
        //   //Kaleigh Note 18 - This is what we need to make sure we can navigate in conditionals.. it waits for other things to finish painting so we dont
        //   //get the error that other things are already being rendered
        //   WidgetsBinding.instance.addPostFrameCallback((_) {
        //     vm.navigateToFriendsPage(context);
        //   });
        // }
        ;
        return Scaffold(
          appBar: const DinderAppBar(),
          bottomNavigationBar: BottomMenu(currentIndex: 0),
          floatingActionButton: IconButton(
            icon: const Icon(Icons.fastfood_outlined),
            onPressed: () {
              // print();
              vm.navigateToFreshMeatPage(context);
            },
          ),
          body: Column(
            children: [
              const Text("HOME!"),
              Text('yo ${vm.displayName}'),
              ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: vm.activeMeats.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: Colors.grey);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final meat = vm.activeMeats[index];
                    return Card(
                      child: InkWell(
                        splashColor: Colors.purple.withAlpha(30),
                        onTap: () {
                          vm.initiateMeatSwipe(context, meat.id);
                        },
                        child: Column(children: [
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(top: 30, left: 30) ),
                          SizedBox(
                            child: Center(
                              child: Text('Date: ${meat.date} at ${meat.time}'),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(left: 30) ),
                          SizedBox(
                            child: Center(
                              child: Text('Location: ${meat.zipcode}'),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 30, left: 30) ),
                          SizedBox(
                            child: Center(
                              child: Text('Number of peeps: ${meat.participants.participants.length}'),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              // vm.removeFriend(friend);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                      ]
                      )
                      ,)
                    );
                  })
            ],
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final String? displayName;
  final List<dynamic> activeMeats;
  final void Function(String newName) updateDisplayName;
  final void Function(BuildContext context) navigateToFriendsPage;
  final void Function(BuildContext context) navigateToFreshMeatPage;
  final void Function() fetchActiveMeats;
  final void Function(BuildContext context, String meatId) initiateMeatSwipe;

  //dont know if we'll use this and add a reducer function or just Meat()
  //May want to read into forms in flutter a bit

  const _ViewModel({
    required this.displayName,
    required this.activeMeats,
    required this.updateDisplayName,
    required this.navigateToFriendsPage,
    required this.navigateToFreshMeatPage,
    required this.fetchActiveMeats,
    required this.initiateMeatSwipe
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService firestoreService = FirestoreService.instance;

    return _ViewModel(
        displayName: store.state.userState.displayName,
        activeMeats: store.state.userState.activeMeats,
        updateDisplayName: (String newName) =>
            store.dispatch(UpdateDisplayName(newName)),
        navigateToFriendsPage: (BuildContext context) {
          Navigator.pushNamed(context, '/friends');
        },
        navigateToFreshMeatPage: (BuildContext context) {
          Navigator.pushNamed(context, '/freshMeat');
        },
        fetchActiveMeats: () {
          store.state.userState.activeMeats.forEach((meat) {
            firestoreService.getUserActiveMeat(meat.id);
          });
        },
        initiateMeatSwipe: (BuildContext context, String meatId) {
          final meat = store.state.userState.activeMeats.where((meat) => meat.id == meatId).first;
          store.dispatch(CreateMeat(meat));
          Navigator.pushNamed(context, "/swipeMeat");
        }
      );
  }
}
