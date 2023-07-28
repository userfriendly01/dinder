class AppState {
  final String name;
  final bool isLoggedIn;

  AppState({this.name = "", this.isLoggedIn = false});

  Map<String, dynamic> toMap() => {"name": name, "isLoggedIn": isLoggedIn };
}
