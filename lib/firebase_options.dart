// File generated for FlutterFire configuration.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8iZk2xVM7JH62Z3W5Jq6sH6fYKTxAM08',
    appId: '1:652861608650:android:c3c8d5b315b3b198439a33',
    messagingSenderId: '652861608650',
    projectId: 'crud-firebase-53cb6',
    storageBucket: 'crud-firebase-53cb6.firebasestorage.app',
  );

  // Placeholder — only Android is configured
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'placeholder-ios',
    appId: 'placeholder-ios',
    messagingSenderId: '652861608650',
    projectId: 'crud-firebase-53cb6',
    storageBucket: 'crud-firebase-53cb6.firebasestorage.app',
    iosBundleId: 'com.example.authCrudEndroid',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'placeholder-macos',
    appId: 'placeholder-macos',
    messagingSenderId: '652861608650',
    projectId: 'crud-firebase-53cb6',
    storageBucket: 'crud-firebase-53cb6.firebasestorage.app',
    iosBundleId: 'com.example.authCrudEndroid',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'placeholder-web',
    appId: 'placeholder-web',
    messagingSenderId: '652861608650',
    projectId: 'crud-firebase-53cb6',
    storageBucket: 'crud-firebase-53cb6.firebasestorage.app',
    authDomain: 'crud-firebase-53cb6.firebaseapp.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'placeholder-windows',
    appId: 'placeholder-windows',
    messagingSenderId: '652861608650',
    projectId: 'crud-firebase-53cb6',
    storageBucket: 'crud-firebase-53cb6.firebasestorage.app',
  );
}