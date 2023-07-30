import 'package:dinder/actions/friends_list_actions.dart';
import 'package:dinder/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/user_state.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  //Kaleigh Note 10: I refactored this to use the view model.. kinda cleaner.. kinda cool.. setup feels tedious but clean
  //Obviously these arent complete, figured I'd wire up something as a guideline for when we wire up more

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
            bottomNavigationBar: BottomMenu(currentIndex: 1),
            body: ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: vm.friendsList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: Colors.grey);
                },
                itemBuilder: (BuildContext context, int index) {
                  final friend = vm.friendsList[index];
                  return ListTile(
                    title: Text(" ${friend.displayName}"),
                    trailing: IconButton(
                      onPressed: () {
                        vm.removeFriend(friend);
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  );
                }));
      },
    );
  }
}

//Kaleigh Note 8: I learned some things about view models that I wasnt SURE if I thought it was worth it
//It does line up with the principles of keeping the UI and business logic separate
//Idk seems like best practice so I figured we could try and be responsible from the get go lol
//This is basically just defining the state variables and dispatches that this screen will need
//and mapping them with friendly names. This ALSO makes it more like react where if we dont do it like this,
//this screen will re-render EVERY time the store changes. For performance, this strategy makes sure screens
//only reload when something they are dependent on reloads.

class _ViewModel {
  final List<User> friendsList;
  final String? searchTerm;
  final void Function(List<User> friends) loadFriends;
  final void Function(User friend) addFriend;
  final void Function(User friend) removeFriend;
  final void Function(String searchTerm) searchFriend;

  const _ViewModel(
      {required this.friendsList,
      required this.searchTerm,
      required this.loadFriends,
      required this.addFriend,
      required this.removeFriend,
      required this.searchFriend});

  //Kaleigh Note 9: Another this that the view model can be used for is filtering/sorting whats being displayed to the user
  // You could create that function here and then use it in the fromStore method
  // If we were using the search term to search within our list, we could just do that here instead of through an action
  // but since that's going to be more of a fetch/API call to firebase auth, I didnt add it here

  static fromStore(Store<AppState> store) {
    return _ViewModel(
        friendsList: store.state.friendsListState.friends,
        searchTerm: store.state.friendsListState.searchTerm,
        loadFriends: (List<User> friends) =>
            store.dispatch(LoadFriendsList(friends)),
        addFriend: (User friend) => store.dispatch(AddFriend(friend)),
        removeFriend: (User friend) => store.dispatch(RemoveFriend(friend)),
        searchFriend: (String searchTerm) =>
            store.dispatch(FindFriend(searchTerm)));
  }
}
