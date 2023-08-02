import '../models/app_user_state.dart';

class UpdateIsLoggedIn {
  final bool updatedIsLoggedIn;

  UpdateIsLoggedIn(this.updatedIsLoggedIn);

  @override
  String toString() =>
      "UpdateIsLoggedIn(updatedIsLoggedIn: $updatedIsLoggedIn)";
}

class LogInUser {
  final AppUser validUser;

  LogInUser(this.validUser);
  @override
  String toString() => "LogInUser(validUser: $validUser)";
}

class LogOutUser {
  LogOutUser();
  @override
  String toString() => "LogOutUser()";
}

class UpdateDisplayName {
  final String newName;

  UpdateDisplayName(this.newName);

  @override
  String toString() => "UpdateDisplayName(user: $newName)";
}

class UpdateFriends {
  final List<String> newFriends;

  UpdateFriends(this.newFriends);

  @override
  String toString() => "UpdateFriends(friends: $newFriends)";
}
