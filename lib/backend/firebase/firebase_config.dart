import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  try {
    print('Starting Firebase initialization...');
    print('Platform: ${kIsWeb ? 'Web' : 'Mobile'}');
    
    if (kIsWeb) {
      print('Initializing Firebase for Web...');
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyCRheJNvEHF3JNHfb6kcWYELvFNy8LMs1Y",
              authDomain: "cefmorsi-d8ffc.firebaseapp.com",
              projectId: "cefmorsi-d8ffc",
              storageBucket: "cefmorsi-d8ffc.appspot.com",
              messagingSenderId: "64058760025",
              appId: "1:64058760025:web:081c4f2ca6b4249bda4a48",
              measurementId: "G-VXNFBGEM76"));
    } else {
      print('Initializing Firebase for Mobile...');
      await Firebase.initializeApp();
    }
    
    print('Firebase.initializeApp() completed');
    print('Firebase.apps.length: ${Firebase.apps.length}');
  
    // Verify Firebase is initialized
    if (Firebase.apps.isEmpty) {
      print('ERROR: Firebase.apps is empty after initialization');
      throw Exception('Firebase initialization failed - no apps found');
    }
    
    print('Firebase initialized successfully with ${Firebase.apps.length} app(s)');
    for (int i = 0; i < Firebase.apps.length; i++) {
      print('App $i: ${Firebase.apps[i].name}');
    }
  } catch (e) {
    print('Firebase initialization error: $e');
    print('Error type: ${e.runtimeType}');
    rethrow;
  }
}
