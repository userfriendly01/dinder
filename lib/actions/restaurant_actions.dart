import '../models/restaurant_state.dart';

class LoadRestaurants {
  final List<Restaurant> restaurants;

  LoadRestaurants(this.restaurants);
}

class UpdateRestaurants {
  final List<Restaurant> updatedRestaurants;

  UpdateRestaurants(this.updatedRestaurants);
}
