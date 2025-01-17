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
    apiKey: 'AIzaSyBXT1ZT4udWGJkQAyXsQ74Zov4VC5HNGPc',
    appId: '1:825184842843:web:c68f45f286391acbadfb7e',
    messagingSenderId: '825184842843',
    projectId: 'pembukuankeuangan-92dc0',
    authDomain: 'pembukuankeuangan-92dc0.firebaseapp.com',
    storageBucket: 'pembukuankeuangan-92dc0.firebasestorage.app',
    measurementId: 'G-97ZEZND8BB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB10ED20scRdfEq2k1B1GMOCMpGXrYZrr4',
    appId: '1:825184842843:android:ada0fb437971ae8cadfb7e',
    messagingSenderId: '825184842843',
    projectId: 'pembukuankeuangan-92dc0',
    storageBucket: 'pembukuankeuangan-92dc0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCnd2SpURAZlH6wbrY94a9GDXdQsWLxeVU',
    appId: '1:825184842843:ios:5d02e0125a1da55eadfb7e',
    messagingSenderId: '825184842843',
    projectId: 'pembukuankeuangan-92dc0',
    storageBucket: 'pembukuankeuangan-92dc0.firebasestorage.app',
    iosBundleId: 'com.example.pembukuanKeuangan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCnd2SpURAZlH6wbrY94a9GDXdQsWLxeVU',
    appId: '1:825184842843:ios:5d02e0125a1da55eadfb7e',
    messagingSenderId: '825184842843',
    projectId: 'pembukuankeuangan-92dc0',
    storageBucket: 'pembukuankeuangan-92dc0.firebasestorage.app',
    iosBundleId: 'com.example.pembukuanKeuangan',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXT1ZT4udWGJkQAyXsQ74Zov4VC5HNGPc',
    appId: '1:825184842843:web:c328f7a7251ef30eadfb7e',
    messagingSenderId: '825184842843',
    projectId: 'pembukuankeuangan-92dc0',
    authDomain: 'pembukuankeuangan-92dc0.firebaseapp.com',
    storageBucket: 'pembukuankeuangan-92dc0.firebasestorage.app',
    measurementId: 'G-45Y6ZMBSQE',
  );

}