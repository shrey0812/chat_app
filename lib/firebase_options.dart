// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
// / import 'firebase_options.dart';
// / // ...
// / await Firebase.initializeApp(
// /   options: DefaultFirebaseOptions.currentPlatform,
// / );
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
    apiKey: 'AIzaSyDpSF93kc2pRXEpHf6M7inJOcNDeDPg5-o',
    appId: '1:513676922307:web:f618a38cbc5ddcc9c44176',
    messagingSenderId: '513676922307',
    projectId: 'my-chat-app-3448e',
    authDomain: 'my-chat-app-3448e.firebaseapp.com',
    storageBucket: 'my-chat-app-3448e.appspot.com',
    measurementId: 'G-6KM685YQBM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDU9a2utEtuwU3nLxEqUivwuuKJ0K-PPbA',
    appId: '1:513676922307:android:138f42dac7bb4b55c44176',
    messagingSenderId: '513676922307',
    projectId: 'my-chat-app-3448e',
    storageBucket: 'my-chat-app-3448e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBA8PFZDCD4t1X37P0HAG8Sx89hSEf_R6E',
    appId: '1:513676922307:ios:56ef5a4055aca97ec44176',
    messagingSenderId: '513676922307',
    projectId: 'my-chat-app-3448e',
    storageBucket: 'my-chat-app-3448e.appspot.com',
    iosClientId:
        '513676922307-8dalu34vlh3feshhosseq4ug71um35pd.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBA8PFZDCD4t1X37P0HAG8Sx89hSEf_R6E',
    appId: '1:513676922307:ios:56ef5a4055aca97ec44176',
    messagingSenderId: '513676922307',
    projectId: 'my-chat-app-3448e',
    storageBucket: 'my-chat-app-3448e.appspot.com',
    iosClientId:
        '513676922307-8dalu34vlh3feshhosseq4ug71um35pd.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
