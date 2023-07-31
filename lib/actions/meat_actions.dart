import '../models/meat_state.dart';

class CreateMeat {
  final Meat meat;

  CreateMeat(this.meat);

  @override
  String toString() => "CreateMeat(meat: $meat)";
}

class SetRestaurantsOnMeat {
  final List<String> cities;

  SetRestaurantsOnMeat(this.cities);

  @override
  String toString() => "SetRestaurantsOnMeat(cities: $cities)";
}
