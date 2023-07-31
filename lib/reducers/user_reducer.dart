import 'package:redux/redux.dart';
import '../actions/user_actions.dart';
import '../models/user_state.dart';

Reducer<User> userReducer = combineReducers<User>([
  TypedReducer<User, LogInUser>(logInUserReducer),
  TypedReducer<User, LogOutUser>(logOutUserReducer),
  TypedReducer<User, UpdateDisplayName>(updateDisplayNameReducer),
]);

//Kaleigh and Faith Note: Not sure how it will work using User around the app for friends
//Our user will be logged in and when we create the friends list made up of other users
//they wont be logged in but how will our App know to look at OUR user. Once we have all our login
//methods in place we may want to walk through that together

//Update - My brain just needed a break, we can make and use these models as much as we want, the state is going
//to maintain the logged in user and other users will be in the other states, users in a friends list etc

User logInUserReducer(
  User state,
  LogInUser action,
) {
  return action.validUser;
}

User logOutUserReducer(
  User state,
  LogOutUser action,
) {
  return state.copyWith(isLoggedIn: false);
}

User updateDisplayNameReducer(
  User state,
  UpdateDisplayName action,
) {
  return state.copyWith(displayName: action.newName);
}
