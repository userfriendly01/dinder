import 'package:dinder/reducers/dismissed_reducer.dart';
import 'package:dinder/reducers/location.reducer.dart';
import '../models/app_state.dart';
import 'friends_list_reducer.dart';
import 'meat_reducer.dart';
import 'restaurant_reducer.dart';
import 'app_user_reducer.dart';

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducer(state.userState, action),
    friendsListState: friendsListReducer(state.friendsListState, action),
    // locationsState: locationsReducer(state.locationsState, action),
    meatState: meatReducer(state.meatState, action),
    restaurantsState: restaurantsReducer(state.restaurantsState, action),
    dismissedState: dismissedRestaurantReducer(state.dismissedState, action),
  );

//Kaleigh Note 15: The long and short of this is we cant use a switch with objects because of the object equality
//issues.. This refactor has the "right" way to do it and I'd vote we trash the switch case thought because it seems
//like a PAIN to work with object equality when its more than just strings, ints etc

  // switch (action) {
  //   case UpdateNameAction:
  //     return AppState(name: action.updatedName);
  //   default:
  //     return state;
  // }
}
