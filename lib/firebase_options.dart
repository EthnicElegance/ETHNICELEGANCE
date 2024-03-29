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
    apiKey: 'AIzaSyDDI1Rj89FX9J8ru6lHDgLciGtCRx9afak',
    appId: '1:882752566173:web:9e65bd1fe624f66edd3574',
    messagingSenderId: '882752566173',
    projectId: 'ethnicelegance-71357',
    authDomain: 'ethnicelegance-71357.firebaseapp.com',
    databaseURL: 'https://ethnicelegance-71357-default-rtdb.firebaseio.com',
    storageBucket: 'ethnicelegance-71357.appspot.com',
    measurementId: 'G-52DZ91F1Y4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNA2WDmfz1n2lGc-GAYZyckbow32urtn4',
    appId: '1:882752566173:android:781183a84bcfc99ddd3574',
    messagingSenderId: '882752566173',
    projectId: 'ethnicelegance-71357',
    databaseURL: 'https://ethnicelegance-71357-default-rtdb.firebaseio.com',
    storageBucket: 'ethnicelegance-71357.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB6ZXPY0nErcEbzxOmydLvX70bqneo4XU4',
    appId: '1:882752566173:ios:2d6e79419c403c3ddd3574',
    messagingSenderId: '882752566173',
    projectId: 'ethnicelegance-71357',
    databaseURL: 'https://ethnicelegance-71357-default-rtdb.firebaseio.com',
    storageBucket: 'ethnicelegance-71357.appspot.com',
    androidClientId: '882752566173-nutd50170fi8re2ue1g7iehsf7f33fej.apps.googleusercontent.com',
    iosClientId: '882752566173-29s4bggbqrb0c3lmo4mvl96isdid5rfe.apps.googleusercontent.com',
    iosBundleId: 'com.example.ethnicElegance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB6ZXPY0nErcEbzxOmydLvX70bqneo4XU4',
    appId: '1:882752566173:ios:3f07bf2dec58d448dd3574',
    messagingSenderId: '882752566173',
    projectId: 'ethnicelegance-71357',
    databaseURL: 'https://ethnicelegance-71357-default-rtdb.firebaseio.com',
    storageBucket: 'ethnicelegance-71357.appspot.com',
    androidClientId: '882752566173-nutd50170fi8re2ue1g7iehsf7f33fej.apps.googleusercontent.com',
    iosClientId: '882752566173-ejceqmftfr7qr33o73clugcqk64m5g2d.apps.googleusercontent.com',
    iosBundleId: 'com.example.ethnicElegance.RunnerTests',
  );
}
