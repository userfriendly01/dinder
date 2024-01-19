import 'package:dinder/actions/friends_list_actions.dart';
import 'package:dinder/models/app_state.dart';
import 'package:flutter/material.dart';
import 'package:dinder/shared/bottom_menu.dart';
import 'package:dinder/shared/app_bar.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../actions/app_user_actions.dart';
import '../services/firestore.dart';
import '../models/app_user_state.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      onInitialBuild: (viewModel) {
        if (viewModel.usersList.isEmpty) {
          viewModel.loadFriends();
        }
      },
      converter: (Store<AppState> store) => _ViewModel.fromStore(store),
      builder: (BuildContext context, _ViewModel vm) {
        return Scaffold(
            appBar: const DinderAppBar(),
            bottomNavigationBar: BottomMenu(currentIndex: 1),
            body: ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemCount: vm.usersList.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(color: Colors.grey);
                },
                itemBuilder: (BuildContext context, int index) {
                  final friend = vm.usersList[index];
                  return ListTile(
                    title: Text(" ${friend.displayName} ${friend.id}"),
                    trailing: vm.appUser.friends.contains(friend.id)
                        ? IconButton(
                            onPressed: () {
                              vm.removeFriend(friend);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        : IconButton(
                            onPressed: () {
                              vm.addFriend(friend);
                            },
                            icon: const Icon(Icons.add),
                          ),
                  );
                })
        );
      },
    );
  }
}

class _ViewModel {
  final AppUser appUser;
  final List<AppUser> usersList;
  final String? searchTerm;
  final void Function() loadFriends;
  final void Function(AppUser friend) addFriend;
  final void Function(AppUser friend) removeFriend;
  final void Function(String searchTerm) searchFriend;

  const _ViewModel(
      {required this.appUser,
      required this.usersList,
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
    final FirestoreService _firestoreService = FirestoreService.instance;

    List<AppUser> filterFriends() {
      return store.state.friendsListState.friends
          .where((element) => element.id != store.state.userState.id)
          .toList();
    }

    return _ViewModel(
        appUser: store.state.userState,
        usersList: filterFriends(),
        searchTerm: store.state.friendsListState.searchTerm,
        loadFriends: () async {
          final possibleFriends = await _firestoreService.getAllUsers().first;
          print(possibleFriends);
          print('yay possible friends ^');
          store.dispatch(LoadFriendsList(possibleFriends));
        },
        addFriend: (AppUser friend) async {
          List<String> newFriends = [
            ...store.state.userState.friends,
            friend.id
          ];
          await _firestoreService.updateUserFriends(
              store.state.userState.id, newFriends);
          store.dispatch(UpdateFriends(newFriends));
        },
        removeFriend: (AppUser friend) async {
          List<String> newFriends = store.state.userState.friends
              .where((element) => element != friend.id)
              .toList();

          await _firestoreService.updateUserFriends(
              store.state.userState.id, newFriends);
          store.dispatch(UpdateFriends(newFriends));
        },
        searchFriend: (String searchTerm) =>
            store.dispatch(FindFriend(searchTerm)));
  }
}
