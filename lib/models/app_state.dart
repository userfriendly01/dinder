import 'package:dinder/models/dismissed_state.dart';
import 'package:dinder/models/friends_list_state.dart';
import 'package:dinder/models/meat_state.dart';
import 'package:dinder/models/restaurant_state.dart';

import 'locations_state.dart';
import 'user_state.dart';

class AppState {
  final User userState;
  final FriendsList friendsListState;
  final LocationOptions locationsState;
  final Meat meatState;
  final Restaurants restaurantsState;
  final DismissedRestaurants dismissedState;

  const AppState(
      {required this.userState,
      required this.friendsListState,
      required this.locationsState,
      required this.meatState,
      required this.restaurantsState,
      required this.dismissedState});

  factory AppState.initial(bool isLoggedIn) {
    return AppState(
        userState: User.initial(isLoggedIn),
        friendsListState: FriendsList.initial(),
        locationsState: LocationOptions.initial(),
        meatState: Meat.initial(),
        restaurantsState: Restaurants.initial(),
        dismissedState: DismissedRestaurants.initial());
  }

  @override
  String toString() {
    return "AppState(userState: $userState, friendsListState: $friendsListState), locationsState: $locationsState, meatState: $meatState, restaurantsState: $restaurantsState, dismissedState: $dismissedState";
  }
}
