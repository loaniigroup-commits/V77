import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/splash_screen.dart';

void main() => runApp(const ExpertsApp());

class ExpertsApp extends StatelessWidget {
  const ExpertsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Experts',
      debugShowCheckedModeBanner: false,
      theme: ExpertsTheme.dark,
      home: const SplashScreen(),
    );
  }
}
