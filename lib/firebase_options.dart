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
    apiKey: 'AIzaSyAQvGP9b7Yc0GXwIBaH0PfvII6pfm1UWxA',
    appId: '1:596068428829:web:d54f44e7c4a7b17aa7aaf4',
    messagingSenderId: '596068428829',
    projectId: 'weather-app-c6bce',
    authDomain: 'weather-app-c6bce.firebaseapp.com',
    storageBucket: 'weather-app-c6bce.appspot.com',
    measurementId: 'G-WBVT9J2RFT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6hmoeGRc_5xFjKNQ5dINHKbYSo5u3g1E',
    appId: '1:596068428829:android:7d39e1fe9ff4c894a7aaf4',
    messagingSenderId: '596068428829',
    projectId: 'weather-app-c6bce',
    storageBucket: 'weather-app-c6bce.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCQgN2L2YmOxXM8DIkB0p8FvZOWVSyooos',
    appId: '1:596068428829:ios:549bac3344b7c42aa7aaf4',
    messagingSenderId: '596068428829',
    projectId: 'weather-app-c6bce',
    storageBucket: 'weather-app-c6bce.appspot.com',
    iosClientId: '596068428829-qml8vfolbc519rksdg228mj1cmn756c6.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCQgN2L2YmOxXM8DIkB0p8FvZOWVSyooos',
    appId: '1:596068428829:ios:549bac3344b7c42aa7aaf4',
    messagingSenderId: '596068428829',
    projectId: 'weather-app-c6bce',
    storageBucket: 'weather-app-c6bce.appspot.com',
    iosClientId: '596068428829-qml8vfolbc519rksdg228mj1cmn756c6.apps.googleusercontent.com',
    iosBundleId: 'com.example.weatherApp',
  );
}
