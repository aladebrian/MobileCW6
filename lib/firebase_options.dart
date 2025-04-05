// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDrRQlzSQTliHZ7j_Nm_4cmbG3CQbRchcI',
    appId: '1:767303132389:web:d78b3122f71f5ea36e200c',
    messagingSenderId: '767303132389',
    projectId: 'mobile-cw-6',
    authDomain: 'mobile-cw-6.firebaseapp.com',
    storageBucket: 'mobile-cw-6.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDkDA6XwOmMw3dFWftoCB332no2cFXy0XI',
    appId: '1:767303132389:android:edeb3aa1f5c3902f6e200c',
    messagingSenderId: '767303132389',
    projectId: 'mobile-cw-6',
    storageBucket: 'mobile-cw-6.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBD9jDje7zAPv2QCH4FG2jIkdFj03ldcr8',
    appId: '1:767303132389:ios:40601eb639b4d79d6e200c',
    messagingSenderId: '767303132389',
    projectId: 'mobile-cw-6',
    storageBucket: 'mobile-cw-6.firebasestorage.app',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBD9jDje7zAPv2QCH4FG2jIkdFj03ldcr8',
    appId: '1:767303132389:ios:40601eb639b4d79d6e200c',
    messagingSenderId: '767303132389',
    projectId: 'mobile-cw-6',
    storageBucket: 'mobile-cw-6.firebasestorage.app',
    iosBundleId: 'com.example.firebaseCrud',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDrRQlzSQTliHZ7j_Nm_4cmbG3CQbRchcI',
    appId: '1:767303132389:web:f368fa2e698e8d2d6e200c',
    messagingSenderId: '767303132389',
    projectId: 'mobile-cw-6',
    authDomain: 'mobile-cw-6.firebaseapp.com',
    storageBucket: 'mobile-cw-6.firebasestorage.app',
  );
}
