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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCS74jFeAiP3LdaTP3NfGIQ_31JI_yUrZA',
    appId: '1:795921981755:web:8ba5cdb29f6eba58fcd71e',
    messagingSenderId: '795921981755',
    projectId: 'kuhaejwo',
    authDomain: 'kuhaejwo.firebaseapp.com',
    storageBucket: 'kuhaejwo.appspot.com',
    measurementId: 'G-LHBBZH8LF0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVNUnRTNmHiiwzYnN-zxotQXppGk4R0Ko',
    appId: '1:795921981755:android:f952b3082110a98efcd71e',
    messagingSenderId: '795921981755',
    projectId: 'kuhaejwo',
    storageBucket: 'kuhaejwo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1Y5mlZTqC77BZ9WQVxJYyB8XM86YSbhI',
    appId: '1:795921981755:ios:7b30ee5540cc76ebfcd71e',
    messagingSenderId: '795921981755',
    projectId: 'kuhaejwo',
    storageBucket: 'kuhaejwo.appspot.com',
    iosClientId: '795921981755-e6f2ok2lkc6ir3kc3gnvhoj6rr0chu7a.apps.googleusercontent.com',
    iosBundleId: 'com.example.petApp',
  );
}