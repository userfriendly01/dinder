import 'package:dinder/services/analytics.dart';
// import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import './services/analytics.dart';

class DinderApp extends StatelessWidget {
  DinderApp({super.key});
  final FirebaseAnalyticsObserver observer = MyAnalyticsService.observer;
  //NOTE: If we use named routes, consider adding the route name as a setting in the MaterialPageRoute to make analytics more clear
  //NOTE: More functionalities are available for areas to observe - skipped remainder of full stack flutter/firebase video on Analytics.
  String get name => 'dinder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Dinder",
        navigatorObservers: <NavigatorObserver>[observer],
        home: Scaffold(
          appBar: AppBar(title: Text("Look at this Fancy App")),
          body: Center(child: Text("Here I am!")),
        ));
  }
}
