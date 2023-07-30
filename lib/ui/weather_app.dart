import 'package:flutter/material.dart';
import 'package:weather/core/ui/theme/app_theme.dart';
import 'package:weather/ui/home/main_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: lightTheme,
      home: const MyHomePage(),
    );
  }
}
