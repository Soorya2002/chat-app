import 'package:chat/auth/auth_handler.dart';
import 'package:chat/screens/homescreen.dart';
import 'package:chat/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Chat App',
    home: AuthHandler(),
    routes: {
      '/home': (context) => HomeScreen(),
      '/login': (context) => LoginScreen(),
    },
  ));
}
