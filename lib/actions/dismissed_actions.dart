import '../models/restaurant_state.dart';

class LoadDismissedList {
  final List<Restaurant> restaurants;

  LoadDismissedList(this.restaurants);

  @override
  String toString() => "restaurants(friends: $restaurants)";
}

class AddRestaurant {
  final Restaurant newDismissedRestaurant;

  AddRestaurant(this.newDismissedRestaurant);

  @override
  String toString() =>
      "AddRestaurant(newDismissedRestaurant: $newDismissedRestaurant)";
}

class RemoveRestaurant {
  final String id;

  RemoveRestaurant(this.id);

  @override
  String toString() => "RemoveRestaurant(dismissedRestaurantId: $id)";
}
