import '../actions/general_actions.dart';
import '../models/app_state.dart';

// TODO: WE NEED TO FIGURE THIS OUT. THEY OVERWRITE EACH OTHER BOO
AppState appReducer(AppState state, dynamic action) {
  if (action is UpdateNameAction) {
    return AppState(name: action.updatedName);
  } else if (action is UpdateIsLoggedIn) {
    return AppState(isLoggedIn: action.updatedIsLoggedIn);  //? will we be overriding things???
  } else {
    return state;
  }

  // switch (action) {
  //   case UpdateNameAction:
  //     return AppState(name: action.updatedName);
  //   default:
  //     return state;
  // }
}
