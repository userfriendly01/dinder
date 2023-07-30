import 'package:dinder/actions/friends_list_actions.dart';
import 'package:dinder/models/friends_list_state.dart';
import 'package:redux/redux.dart';

//Kaleigh Note 11: Ok this is where I went brooo this is a little much. Giving each action its own reducer...
//The only reason I am trying it is because THIS is the solution to not needing all those if/else conditions
// I guess its more performant and easier to read when we dont have to go through all of those conditionals
Reducer<FriendsList> friendsListReducer = combineReducers<FriendsList>([
  TypedReducer<FriendsList, LoadFriendsList>(loadFriendsReducer),
  TypedReducer<FriendsList, AddFriend>(addFriendReducer),
  TypedReducer<FriendsList, RemoveFriend>(removeFriendReducer),
]);

FriendsList loadFriendsReducer(
  FriendsList state,
  LoadFriendsList action,
) {
  return state.copyWith(friends: action.friends);
}

FriendsList addFriendReducer(
  FriendsList state,
  AddFriend action,
) {
  final newFriend = action.newFriend;
  //Kaleigh Note 12: Hey look something can spread! lol
  final newFriends = [...state.friends, newFriend];

  //Kaleigh Note 13: This is where we can use that copyWith to avoid having to spread an object
  return state.copyWith(friends: newFriends);
}

FriendsList removeFriendReducer(
  FriendsList state,
  RemoveFriend action,
) {
  //Kaleigh Note 14: I heard a bit about difficulties when doing object equality. I dont think this != will work
  //because they do a reference equality check. When we get here we can look into how to add another helper function
  //to the friends state file where we can properly check equality. OR it would be nice if all the auth responses had
  //a common attribute to go off, like email.. we will see

  //same with deleting from restaurants
  final trimmedFriends =
      state.friends.where((friend) => friend != action.friend).toList();

  return state.copyWith(friends: trimmedFriends);
}
