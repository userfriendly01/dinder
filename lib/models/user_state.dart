class User {
  final bool isLoggedIn;
  final String? displayName;
  final String? email;

  User({required this.isLoggedIn, this.displayName, this.email});

  factory User.initial(bool isLoggedIn) {
    return User(isLoggedIn: isLoggedIn, displayName: "", email: "");
  }

  //Kaleigh Note 1- This is the "spread" we were looking for with the reducers.. Basically models/
  //classes arent as flexible out of the gate as a javascript object. BUT this class should store
  //any and all utilities to make using the class easier.

  User copyWith({bool? isLoggedIn, String? displayName, String? email}) {
    return User(
        isLoggedIn: isLoggedIn ?? this.isLoggedIn,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email);
  }

  //Kaleigh Note 2 - This is supposedly helpful when debugging to make the console logs prettier. From what
  //i've watched thats mostly why we override this
  @override
  String toString() {
    return "User(isLoggedIn: $isLoggedIn, name: $displayName, email: $email)";
  }
}
