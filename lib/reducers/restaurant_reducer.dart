import '../actions/restaurant_actions.dart';
import '../models/restaurant_state.dart';
import 'package:redux/redux.dart';

Reducer<Restaurants> restaurantsReducer = combineReducers<Restaurants>([
  TypedReducer<Restaurants, LoadRestaurants>(loadRestaurantsReducer),
  TypedReducer<Restaurants, UpdateRestaurants>(updateRestaurantsReducer),
]);

Restaurants loadRestaurantsReducer(
  Restaurants state,
  LoadRestaurants action,
) {
  return state.copyWith(restaurants: action.restaurants);
}

Restaurants updateRestaurantsReducer(
  Restaurants state,
  UpdateRestaurants action,
) {
  return state.copyWith(restaurants: action.updatedRestaurants);
}
