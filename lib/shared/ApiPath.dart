class ApiPath {
  static String get allUsers => 'Users';
  static String get allMeats => 'Meats';
  static String userById(String id) => 'Users/$id';
  static String meatById(String id) => 'Meats/$id';
}
