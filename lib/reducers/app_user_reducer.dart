import 'package:redux/redux.dart';
import '../actions/app_user_actions.dart';
import '../models/app_user_state.dart';

Reducer<AppUser> userReducer = combineReducers<AppUser>([
  TypedReducer<AppUser, LogInUser>(logInUserReducer),
  TypedReducer<AppUser, LogOutUser>(logOutUserReducer),
  TypedReducer<AppUser, UpdateDisplayName>(updateDisplayNameReducer),
]);

//Kaleigh and Faith Note: Not sure how it will work using AppUser around the app for friends
//Our user will be logged in and when we create the friends list made up of other users
//they wont be logged in but how will our App know to look at OUR user. Once we have all our login
//methods in place we may want to walk through that together

//Update - My brain just needed a break, we can make and use these models as much as we want, the state is going
//to maintain the logged in user and other users will be in the other states, users in a friends list etc

AppUser logInUserReducer(
  AppUser state,
  LogInUser action,
) {
  return action.validUser;
}

AppUser logOutUserReducer(
  AppUser state,
  LogOutUser action,
) {
  return state.copyWith(isLoggedIn: false);
}

AppUser updateDisplayNameReducer(
  AppUser state,
  UpdateDisplayName action,
) {
  return state.copyWith(displayName: action.newName);
}
