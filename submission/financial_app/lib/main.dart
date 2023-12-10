import 'package:financial_app/ui/screen/main/MainScreen.dart';
import 'package:financial_app/ui/screen/splash/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Finance',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: true,
        fontFamily: 'Nunito',
      ),
      home: const SplashScreen(),
      routes: {
        "/main": (_) => const MainScreen(),
      },
    );
  }
}
