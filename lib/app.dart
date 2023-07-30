import 'package:dinder/models/app_state.dart';
import 'package:dinder/screens/login_screen.dart';
import 'package:dinder/services/analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import './screens/friends_screen.dart';
import './screens/my_profile_screen.dart';
import './screens/home_screen.dart';

class DinderApp extends StatelessWidget {
  final Store<AppState> store;

  DinderApp({Key? key, required this.store}) : super(key: key);

  final FirebaseAnalyticsObserver observer = MyAnalyticsService.observer;
  //NOTE: If we use named routes, consider adding the route name as a setting in the MaterialPageRoute to make analytics more clear
  //NOTE: More functionalities are available for areas to observe - skipped remainder of full stack flutter/firebase video on Analytics.
  String get name => 'dinder';

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, _ViewModel>(
        converter: (Store<AppState> store) => _ViewModel.fromStore(store),
        builder: (context, state) {
          print(state);
          return MaterialApp(
              title: "Dinder",
              navigatorObservers: <NavigatorObserver>[observer],
              theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true),
              routes: {
                '/': (context) => LoginScreen(),
                '/home': (context) => HomeScreen(),
                '/friends': (context) => FriendsScreen(),
                '/myprofile': (context) => MyProfileScreen(),
              },
              initialRoute: '/');
        },
      ),
    );
  }
}

class _ViewModel {
  const _ViewModel();

  static fromStore(Store<AppState> store) {
    return _ViewModel();
  }
}
