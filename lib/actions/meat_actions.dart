import '../models/meat_state.dart';

//Kaleigh and Faith Note - this seems duplicative if we're passing a meat - not sure how it should work
//#forms
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
