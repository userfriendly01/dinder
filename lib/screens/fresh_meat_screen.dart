import 'package:dinder/actions/app_user_actions.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:dinder/models/app_state.dart';
import '../actions/friends_list_actions.dart';
import 'package:dinder/shared/app_bar.dart';
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
  String _errorMessage = "";

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
          appBar: const DinderAppBar(),
          body: Container(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text("Create A New Meat!", style: TextStyle( fontWeight: FontWeight.bold, fontSize: 22),),
                  const Padding(padding: EdgeInsets.all(30)),
                  const Text("Where do you want to meat?"),
                  TextField(
                    controller: zipcodeController,
                    decoration: const InputDecoration( hintText: "Zipcode"),
                  ),
                  const Padding(padding: EdgeInsets.all(30)),
                  Text(vm.friendsList.isEmpty ? "Oh no! You need some friends" : "Select your friends"),
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
                        selectedTileColor: const Color.fromARGB(255, 196, 169, 208),
                        onTap: () {
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(_errorMessage, style: const TextStyle(color: Colors.red),),
                  ),
                  // If user has no friends we render a button that navigates to the friend page
                  vm.friendsList.isNotEmpty ? ElevatedButton(
                    onPressed: () {
                      bool isZipValid = RegExp(r"^\d{5}(-\d{4})?$", caseSensitive: false).hasMatch(zipcodeController.text);
                      if (_selectedFriendsList.isEmpty) {
                        setState(() {
                          _errorMessage = "Oops, select some friends.";
                        });
                      } else if (zipcodeController.text == "") {
                        setState(() {
                          _errorMessage = "Oh no!  Enter a zipcode.";
                        });
                      } else if (!isZipValid) {
                        setState(() {
                          _errorMessage = "Hmmmm... I don't think that zipcode is real...";
                        });
                      } else {
                        setState(() {
                          _errorMessage = "";
                        });
                      }
                      // Todo: navigate to the next screen
                    },
                    child: const Text("Create Meat-Up")
                  ) : ElevatedButton(
                    onPressed: () {
                    Navigator.pushNamed(context, "/friends");
                    }, 
                    child: const Text("Find some Friends")
                  ),
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

  const _ViewModel({
    required this.displayName,
    required this.loadFriends,
    required this.friendsList,
  });

  static fromStore(Store<AppState> store) {
    final FirestoreService firestoreService = FirestoreService.instance;

    List<AppUser> formatFriends() {
      return store.state.friendsListState.friends
          .where((element) => store.state.userState.friends.contains(element.id))
          .toList();
    }

    return _ViewModel(
      displayName: store.state.userState.displayName != "" ? "${store.state.userState.displayName}'s" : "My",
      friendsList: formatFriends(),
      loadFriends: () async {
        final possibleFriends = await firestoreService.getAllUsers().first;
        print(possibleFriends);
        print('yay possible friends ^');
        store.dispatch(LoadFriendsList(possibleFriends));
      },
    );
  }
}