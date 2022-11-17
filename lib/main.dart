import 'package:author_registeration_app/screens/homepage.dart';
import 'package:author_registeration_app/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      //initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'splash_screen': (context) => SplashScreen()
      },
    ),
  );
}
