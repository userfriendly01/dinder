import '../actions/location_actions.dart';
import '../models/locations_state.dart';
import 'package:redux/redux.dart';

Reducer<LocationOptions> locationsReducer = combineReducers<LocationOptions>([
  TypedReducer<LocationOptions, ConcatCities>(concatCitiesReducer),
  TypedReducer<LocationOptions, TrimCities>(trimCitiesReducer),
]);

LocationOptions concatCitiesReducer(
  LocationOptions state,
  ConcatCities action,
) {
  return state.copyWith(cities: action.addedCities);
}

LocationOptions trimCitiesReducer(
  LocationOptions state,
  TrimCities action,
) {
  return state.copyWith(cities: action.removedCities);
}
