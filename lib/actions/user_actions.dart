import "../models/user_state.dart";

class UpdateIsLoggedIn {
  final bool updatedIsLoggedIn;

  UpdateIsLoggedIn(this.updatedIsLoggedIn);

  @override
  String toString() =>
      "UpdateIsLoggedIn(updatedIsLoggedIn: $updatedIsLoggedIn)";
}

class LogInUser {
  final User validUser;

  LogInUser(this.validUser);
  @override
  String toString() => "LogInUser(validUser: $validUser)";
}

class LogOutUser {
  final User user;

  LogOutUser(this.user);
  @override
  String toString() => "LogOutUser(user: $user)";
}

class UpdateDisplayName {
  final String newName;

  UpdateDisplayName(this.newName);

  @override
  String toString() => "UpdateDisplayName(user: $newName)";
}
