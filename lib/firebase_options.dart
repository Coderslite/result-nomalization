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
    apiKey: 'AIzaSyD1q9engfBrC3OI5taCVkkzkwI_8IQK-ss',
    appId: '1:111313636154:web:3c1ade2191aa6373eb1e03',
    messagingSenderId: '111313636154',
    projectId: 'onah-s-project',
    authDomain: 'onah-s-project.firebaseapp.com',
    storageBucket: 'onah-s-project.appspot.com',
    measurementId: 'G-J7C8613C5Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD2VHRhc10yEMEheTQtrrUb-VrsHicq7Z4',
    appId: '1:111313636154:android:4edb4fa4454dc4e4eb1e03',
    messagingSenderId: '111313636154',
    projectId: 'onah-s-project',
    storageBucket: 'onah-s-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCKwKY7yTXapgw4ibB4nln8u87Gd5Uls9w',
    appId: '1:111313636154:ios:f81c13d94c16377eeb1e03',
    messagingSenderId: '111313636154',
    projectId: 'onah-s-project',
    storageBucket: 'onah-s-project.appspot.com',
    iosClientId: '111313636154-0spv1p93gmvh3qe47asj50i6h5sg03bh.apps.googleusercontent.com',
    iosBundleId: 'com.example.onahProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCKwKY7yTXapgw4ibB4nln8u87Gd5Uls9w',
    appId: '1:111313636154:ios:f81c13d94c16377eeb1e03',
    messagingSenderId: '111313636154',
    projectId: 'onah-s-project',
    storageBucket: 'onah-s-project.appspot.com',
    iosClientId: '111313636154-0spv1p93gmvh3qe47asj50i6h5sg03bh.apps.googleusercontent.com',
    iosBundleId: 'com.example.onahProject',
  );
}