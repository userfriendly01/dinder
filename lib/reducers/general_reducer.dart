import '../actions/general_actions.dart';
import '../models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is UpdateNameAction) {
    return AppState(name: action.updatedName);
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
