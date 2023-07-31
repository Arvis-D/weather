import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:weather/ui/weather_app.dart';

void main() {
  Fimber.plantTree(DebugTree());
  runApp(const WeatherApp());
}
