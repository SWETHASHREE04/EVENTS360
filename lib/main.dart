// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyATECPpyOZmtUHP_36Ovdmvo4rlY8WQQ0s",
      authDomain: "events360-92269.firebaseapp.com",
      projectId: "events360-92269",
      storageBucket: "events360-92269.appspot.com",
      messagingSenderId: "361180027458",
      appId: "1:361180027458:android:ee236b82cdb73d01ee6bdb",
    ),
  ); // Ensure Firebase is initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(), // Set the login screen as the home
    );
  }
}
