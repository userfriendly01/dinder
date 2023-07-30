import 'user_state.dart';

class FriendsList {
  final List<User> friends;
  final String? searchTerm;

  FriendsList({required this.friends, this.searchTerm});

  factory FriendsList.initial() {
    return FriendsList(friends: [
      User(
          isLoggedIn: false,
          displayName: "Example Friend",
          email: "deletemelater@gmail.com")
    ], searchTerm: "");
  }

  // Kaleigh Note 3: We dont REALLY need this with only one variable in this state
  // but its more for consistency and scalability if we ever add more
  FriendsList copyWith({List<User>? friends, String? searchTerm}) {
    return FriendsList(
        friends: friends ?? this.friends,
        searchTerm: searchTerm ?? this.searchTerm);
  }

  @override
  String toString() {
    return "FriendsList(friends $friends, searchTerm $searchTerm)";
  }
}
