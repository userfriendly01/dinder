import '../actions/general_actions.dart';
import '../models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is UpdateNameAction) {
    return AppState(name: action.updatedName);
  } else if (action is UpdateIsLoggedIn) {
    return AppState(
        name: state.name,
        isLoggedIn:
            action.updatedIsLoggedIn); //? will we be overriding things???
  } else {
    return state;
  }

// TODO: Is there a lazier way to do this or just use and combine reducers to reduce overall duplicated code

//   AppState appStateReducer(AppState state, action) {
//   return AppState(
//     items: itemsReducer(state.items, action),
//     count: incrementReducer(state.count, action),
//   );
// }

  // switch (action) {
  //   case UpdateNameAction:
  //     return AppState(name: action.updatedName);
  //   default:
  //     return state;
  // }
}
