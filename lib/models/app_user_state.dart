import 'package:json_annotation/json_annotation.dart';

part 'app_user_state.g.dart';

@JsonSerializable()
class AppUser {
  final bool isLoggedIn;
  final String? displayName;
  final String? email;

  AppUser({required this.isLoggedIn, this.displayName, this.email});

  factory AppUser.initial(bool isLoggedIn) {
    return AppUser(isLoggedIn: isLoggedIn, displayName: "", email: "");
  }

  //Kaleigh Note 1- This is the "spread" we were looking for with the reducers.. Basically models/
  //classes arent as flexible out of the gate as a javascript object. BUT this class should store
  //any and all utilities to make using the class easier.

  AppUser copyWith({bool? isLoggedIn, String? displayName, String? email}) {
    return AppUser(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email);
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);

  //Kaleigh Note 2 - This is supposedly helpful when debugging to make the console logs prettier. From what
  //i've watched thats mostly why we override this
  @override
  String toString() {
    return "AppUser(isLoggedIn: $isLoggedIn, name: $displayName, email: $email)";
  }
}
