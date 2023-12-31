// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
import 'firebase_options.dart';

// ...
//  await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB7N2Y-K_d4ceO7ZrjnWCrDhmjwlLF7GWo',
    appId: '1:712300422241:web:b2538742f68ec29ba5b620',
    messagingSenderId: '712300422241',
    projectId: 'dinder-e2ec6',
    authDomain: 'dinder-e2ec6.firebaseapp.com',
    storageBucket: 'dinder-e2ec6.appspot.com',
    measurementId: 'G-EVYN4SRP37',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbIlMW7Yvadz1rP-e6A9-uD89zJye0S80',
    appId: '1:712300422241:android:cff671d6c45d6070a5b620',
    messagingSenderId: '712300422241',
    projectId: 'dinder-e2ec6',
    storageBucket: 'dinder-e2ec6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDLRN8A9isJU8RqwMvQYHdyPWFNg9DB19A',
    appId: '1:712300422241:ios:218b69ba3c1a4563a5b620',
    messagingSenderId: '712300422241',
    projectId: 'dinder-e2ec6',
    storageBucket: 'dinder-e2ec6.appspot.com',
    iosClientId:
        '712300422241-mu1jcohf0e8kgvdgvpqie36oq833n27v.apps.googleusercontent.com',
    iosBundleId: 'com.example.dinder',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDLRN8A9isJU8RqwMvQYHdyPWFNg9DB19A',
    appId: '1:712300422241:ios:d30cc2a150145bb3a5b620',
    messagingSenderId: '712300422241',
    projectId: 'dinder-e2ec6',
    storageBucket: 'dinder-e2ec6.appspot.com',
    iosClientId:
        '712300422241-0dqmm6f9cgphhn06fv2gus5vhsil5ta2.apps.googleusercontent.com',
    iosBundleId: 'com.example.dinder.RunnerTests',
  );
}
