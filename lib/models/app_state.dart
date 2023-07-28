class AppState {
  final String name;

  AppState({this.name = ""});

  Map<String, dynamic> toMap() => {"name": name};
}
