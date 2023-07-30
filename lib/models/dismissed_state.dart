import 'package:dinder/models/restaurant_state.dart';

//Kaleigh Note 5: I looked into an API and realized they had things like dunkin donuts which
//makes sense but who wants to go there. So I figured a down swipe in the app could
//represent adding the restaurant name to a dismissed list attached to a user in the state.
// Then when we create a new meat, we can concat the users hard no's so we only show
// options the pair or group would say yes to

class DismissedRestaurants {
  final List<Restaurant> restaurants;

  DismissedRestaurants({required this.restaurants});

  factory DismissedRestaurants.initial() {
    return DismissedRestaurants(restaurants: []);
  }

  DismissedRestaurants copyWith({List<Restaurant>? restaurants}) {
    return DismissedRestaurants(restaurants: restaurants ?? this.restaurants);
  }

  @override
  String toString() {
    return "DismissedRestaurants(restaurants: $restaurants)";
  }
}
