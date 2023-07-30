import '../models/user_state.dart';

class LoadFriendsList {
  final List<User> friends;

  LoadFriendsList(this.friends);

  @override
  String toString() => "LoadFriendsList(friends: $friends)";
}

//Kaleigh & Faith Note - not sure if we'll need this one since
//the search criteria is going to be used in an API call and maybe not
//in a state update.. we'll see

class FindFriend {
  final String searchTerm;

  FindFriend(this.searchTerm);

  @override
  String toString() => "FindFriend(searchTerm: $searchTerm)";
}

class AddFriend {
  final User newFriend;

  AddFriend(this.newFriend);

  @override
  String toString() => "AddFriend(newFriend: $newFriend)";
}

class RemoveFriend {
  final User friend;

  RemoveFriend(this.friend);

  @override
  String toString() => "RemoveFriend(aww bye friend: $friend)";
}
