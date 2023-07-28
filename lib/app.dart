import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'firebase_options.dart';

class DinderApp extends StatelessWidget {
  const DinderApp({super.key});

  String get name => '"Not sure what this should be"';

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Initialized default app $app');
  }

  Future<void> initializeDefaultFromAndroidResource() async {
    if (defaultTargetPlatform != TargetPlatform.android || kIsWeb) {
      print('Not running on Android, skipping');
      return;
    }
    FirebaseApp app = await Firebase.initializeApp();
    print('Initialized default app $app from Android resource');
  }

  Future<void> initializeSecondary() async {
    FirebaseApp app = await Firebase.initializeApp(
      name: name,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    print('Initialized $app');
  }

  void apps() {
    final List<FirebaseApp> apps = Firebase.apps;
    print('Currently initialized apps: $apps');
  }

  void options() {
    final FirebaseApp app = Firebase.app();
    final options = app.options;
    print('Current options for app ${app.name}: $options');
  }

  Future<void> delete() async {
    final FirebaseApp app = Firebase.app(name);
    await app.delete();
    print('App $name deleted');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Dinder",
        home: Scaffold(
          appBar: AppBar(title: Text("Look at this Fancy App")),
          body: Center(child: Text("I'm Here!")),
        ));
  }
}
