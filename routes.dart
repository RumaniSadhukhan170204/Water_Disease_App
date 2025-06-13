import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/disease_result_screen.dart';
import 'screens/alert_screen.dart';
import 'screens/settings_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
  '/result': (context) => const DiseaseResultScreen(),
  '/alert': (context) => const AlertScreen(),
  '/settings': (context) => const SettingsScreen(),
};
