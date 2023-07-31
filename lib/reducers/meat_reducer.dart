import 'package:redux/redux.dart';
import '../actions/meat_actions.dart';
import '../models/meat_state.dart';

Reducer<Meat> meatReducer = combineReducers<Meat>([
  TypedReducer<Meat, CreateMeat>(createMeatReducer),
  TypedReducer<Meat, SetRestaurantsOnMeat>(setRestaurantsOnMeatReducer),
]);

Meat createMeatReducer(
  Meat state,
  CreateMeat action,
) {
  return action.meat;
}

Meat setRestaurantsOnMeatReducer(
  Meat state,
  SetRestaurantsOnMeat action,
) {
  return state.copyWith(cities: action.cities);
}
