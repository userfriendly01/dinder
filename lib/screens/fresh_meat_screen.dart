import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';
import '../actions/friends_list_actions.dart';
import '../models/app_user_state.dart';
import '../services/firestore.dart';
import '../services/auth.dart';

// Multi select list of friends to make a meet
// Field to collect zipcode
// create meat-up button - which does the search and brings you to another screen

class FreshMeatScreen extends StatefulWidget {
  const FreshMeatScreen({super.key});

  @override
  State<FreshMeatScreen> createState() => _FreshMeatScreenState();
}

class _FreshMeatScreenState extends State<FreshMeatScreen> {
  final TextEditingController zipcodeController = TextEditingController();
  List<String> _selectedFriendsList = [];

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInitialBuild: (viewModel) {
        if (viewModel.friendsList.isEmpty) {
          viewModel.loadFriends();
        }
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
          body: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Create A New Meat!"),
                  TextField(
                    controller: zipcodeController,
                    decoration: const InputDecoration( hintText: "Zipcode"),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  ElevatedButton(
                    onPressed: () {
                      print(vm.friendsList);
                    },
                    child: const Text("Log Out")
                  ),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: vm.friendsList.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: Colors.grey);
                    },
                    itemBuilder: (BuildContext context, int index) {
                      final friend = vm.friendsList[index];
                      return ListTile(
                        title: Text("${friend.displayName}"),
                        selected: _selectedFriendsList.contains(friend.id),
                        selectedTileColor: Color.fromARGB(255, 181, 133, 204),
                        onTap: () {
                          print("Tapped ${friend.displayName}");
                          List<String> updatedList = _selectedFriendsList;
                          if (_selectedFriendsList.contains(friend.id)) {
                            print("REMOVE ${friend.id}");
                            updatedList.remove(friend.id);
                          } else {
                            print("ADD ${friend.id}");
                            updatedList.add(friend.id);
                          }
                          setState(() {
                            _selectedFriendsList = updatedList;
                          });
                        },
                      );
                    },
                  )

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
  final String? displayName;
  final void Function() loadFriends;
  final List<AppUser> friendsList;
  static AuthService _authService = AuthService.instance;

  const _ViewModel({
    required this.displayName,
    required this.loadFriends,
    required this.friendsList,
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService _firestoreService = FirestoreService.instance;

    List<AppUser> formatFriends() {
      return store.state.friendsListState.friends
          .where((element) => store.state.userState.friends.contains(element.id))
          .toList();
    }

    return _ViewModel(
      displayName: store.state.userState.displayName != "" ? "${store.state.userState.displayName}'s" : "My",
      friendsList: formatFriends(),
      loadFriends: () async {
        final possibleFriends = await _firestoreService.getAllUsers().first;
        print(possibleFriends);
        print('yay possible friends ^');
        store.dispatch(LoadFriendsList(possibleFriends));
      },
    );
  }
}
