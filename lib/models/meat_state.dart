import 'package:dinder/models/restaurant_state.dart';

class Meat {
  final String meatId;
  final List<String> cities;
  final String state;
  final List<Restaurant> restaurants;
  //Kaleigh & Faith Note: we may want to filter the list when we first get it from the API on
  //restarant name so they dont have to swipe left for 16 nadeaus subs

  //I dont think we need to save the "left swiped" restaurants within the local state because we would update
  //the database and have a listener for when a match was identified that would push a notification to both users

  //Kaleigh Note 4: .... LOL
  Meat(
      {required this.meatId,
      required this.cities,
      required this.state,
      required this.restaurants});

  factory Meat.initial() {
    return Meat(meatId: "", cities: [], state: "", restaurants: []);
  }

  Meat copyWith(
      {String? meatId,
      List<String>? cities,
      String? state,
      List<Restaurant>? restaurants}) {
    return Meat(
        meatId: meatId ?? this.meatId,
        cities: cities ?? this.cities,
        state: state ?? this.state,
        restaurants: restaurants ?? this.restaurants);
  }

  @override
  String toString() {
    return "Meat(meatId: $meatId), cities: $cities, state: $state, restaurants: $restaurants";
  }
}
