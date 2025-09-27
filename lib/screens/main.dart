import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:society/screens/home_page.dart';
import 'package:society/screens/loginpage.dart';
import 'profile_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Society',
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
