import 'package:redux/redux.dart';
import '../actions/dismissed_actions.dart';
import '../models/dismissed_state.dart';

Reducer<DismissedRestaurants> dismissedRestaurantReducer =
    combineReducers<DismissedRestaurants>([
  TypedReducer<DismissedRestaurants, LoadDismissedList>(
      loadDismissedListReducer),
  TypedReducer<DismissedRestaurants, AddRestaurant>(addToDismissedListReducer),
  TypedReducer<DismissedRestaurants, RemoveRestaurant>(
      removeFromDismissedListReducer),
]);

DismissedRestaurants loadDismissedListReducer(
  DismissedRestaurants state,
  LoadDismissedList action,
) {
  return state.copyWith(restaurants: action.restaurants);
}

DismissedRestaurants addToDismissedListReducer(
  DismissedRestaurants state,
  AddRestaurant action,
) {
  final newRestaurant = action.newDismissedRestaurant;
  final newList = [...state.restaurants, newRestaurant];

  return state.copyWith(restaurants: newList);
}

DismissedRestaurants removeFromDismissedListReducer(
  DismissedRestaurants state,
  RemoveRestaurant action,
) {
  final trimmedRestaurants =
      state.restaurants.where((r) => r.id != action.id).toList();
  return state.copyWith(restaurants: trimmedRestaurants);
}
