import 'package:flutter/material.dart';
import 'package:findingcafe_2/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBZWt5FHebxj4MhlNZxYVbLigi15bzDPUA",
          authDomain: "finding-d8a5b.firebaseapp.com",
          projectId: "finding-d8a5b",
          storageBucket: "finding-d8a5b.appspot.com",
          messagingSenderId: "570859890462",
          appId: "1:570859890462:web:41b64899a108eaf3438b0f",
          measurementId: "G-JZCDF1RR1T"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finding Cafe Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(title: 'Finding cafe Demo Home Page'),
    );
  }
}
