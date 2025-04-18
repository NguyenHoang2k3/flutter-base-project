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
    apiKey: 'AIzaSyC5yWllqBWSE3W0Es1sDWZBqsOgM4GRSFg',
    appId: '1:483009027645:web:806779e69b48df33bc9454',
    messagingSenderId: '483009027645',
    projectId: 'flutter-kabar',
    authDomain: 'flutter-kabar.firebaseapp.com',
    storageBucket: 'flutter-kabar.firebasestorage.app',
    measurementId: 'G-SXWR7HZ8RR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAR5OWclUwTFhCgIzbE1LSfMES4QpN20P8',
    appId: '1:483009027645:android:88da082cac8741f3bc9454',
    messagingSenderId: '483009027645',
    projectId: 'flutter-kabar',
    storageBucket: 'flutter-kabar.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC02SkOQUStlU2XTnhdoKqRPIXxN8MnfVw',
    appId: '1:483009027645:ios:3ba75e8abbf580babc9454',
    messagingSenderId: '483009027645',
    projectId: 'flutter-kabar',
    storageBucket: 'flutter-kabar.firebasestorage.app',
    iosBundleId: 'com.example.flutterCleanArchitecture',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC02SkOQUStlU2XTnhdoKqRPIXxN8MnfVw',
    appId: '1:483009027645:ios:3ba75e8abbf580babc9454',
    messagingSenderId: '483009027645',
    projectId: 'flutter-kabar',
    storageBucket: 'flutter-kabar.firebasestorage.app',
    iosBundleId: 'com.example.flutterCleanArchitecture',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC5yWllqBWSE3W0Es1sDWZBqsOgM4GRSFg',
    appId: '1:483009027645:web:0e88adb30958c1dcbc9454',
    messagingSenderId: '483009027645',
    projectId: 'flutter-kabar',
    authDomain: 'flutter-kabar.firebaseapp.com',
    storageBucket: 'flutter-kabar.firebasestorage.app',
    measurementId: 'G-SZZW7TXVGQ',
  );
}
