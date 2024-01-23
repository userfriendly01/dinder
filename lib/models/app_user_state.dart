import 'package:json_annotation/json_annotation.dart';

import 'meat_state.dart';

part 'app_user_state.g.dart';

@JsonSerializable()
class AppUser {
  final String id;
  final bool isLoggedIn;
  final String? displayName;
  final String? email;
  final List<String> friends;
  final List<String> dismissed;
  final List<dynamic> activeMeats;

  AppUser(
      {required this.id,
      required this.isLoggedIn,
      this.displayName,
      this.email,
      required this.friends,
      required this.dismissed,
      required this.activeMeats});

  factory AppUser.initial(bool isLoggedIn) {
    return AppUser(
        id: "",
        isLoggedIn: isLoggedIn,
        displayName: "",
        email: "",
        friends: [],
        dismissed: [],
        activeMeats: []);
  }

  //Kaleigh Note 1- This is the "spread" we were looking for with the reducers.. Basically models/
  //classes arent as flexible out of the gate as a javascript object. BUT this class should store
  //any and all utilities to make using the class easier.

  AppUser copyWith(
      {String? id,
      bool? isLoggedIn,
      String? displayName,
      String? email,
      List<String>? friends,
      List<String>? dismissed,
      List<Meat>? activeMeats}) {
    return AppUser(
        id: id ?? this.id,
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
        friends: friends ?? this.friends,
        dismissed: dismissed ?? this.dismissed,
        activeMeats: activeMeats ?? this.activeMeats);
  }

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

//Find a way to fix active meat instantiation here vs the generated file
  @override
  String toString() {
    return "AppUser(id: $id, isLoggedIn: $isLoggedIn, name: $displayName, email: $email, friends: $friends, dismissed: $dismissed, activeMeats: $activeMeats)";
  }
}

// dart run build_runner build
