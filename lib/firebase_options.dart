// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
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
    apiKey: 'AIzaSyCj0eS4-zM2IuZyNmjbfN6ffzf8-3TAQ9Q',
    appId: '1:78527489523:web:74d2a297724c6bb6419e86',
    messagingSenderId: '78527489523',
    projectId: 'car-parking-bad2d',
    authDomain: 'car-parking-bad2d.firebaseapp.com',
    storageBucket: 'car-parking-bad2d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDOGbe2whxgpea8iWr5-Jke4WykybHdjM',
    appId: '1:78527489523:android:5805f9fd2a9fd062419e86',
    messagingSenderId: '78527489523',
    projectId: 'car-parking-bad2d',
    storageBucket: 'car-parking-bad2d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAVd9bWhsWj1V9YNEkPcMkq09JrI1PnzAU',
    appId: '1:78527489523:ios:a7200bd56d665641419e86',
    messagingSenderId: '78527489523',
    projectId: 'car-parking-bad2d',
    storageBucket: 'car-parking-bad2d.appspot.com',
    iosBundleId: 'com.example.parkingSystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAVd9bWhsWj1V9YNEkPcMkq09JrI1PnzAU',
    appId: '1:78527489523:ios:e67a9dffd82e8268419e86',
    messagingSenderId: '78527489523',
    projectId: 'car-parking-bad2d',
    storageBucket: 'car-parking-bad2d.appspot.com',
    iosBundleId: 'com.example.parkingSystem.RunnerTests',
  );
}
