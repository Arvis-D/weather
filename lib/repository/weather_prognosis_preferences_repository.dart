import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/config.dart';
import 'package:weather/model/local/weather_prognosis.dart';
import 'package:weather/repository/weather_prognosis_repository.dart';

class WeatherPrognosisPreferencesRepository
    implements WeatherPrognosisRepository {
  WeatherPrognosisPreferencesRepository();

  static const String _key = Config.weatherPrognosisSharedPreferencesKey;

  @override
  Future<WeatherPrognosis?> getWeather() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedJson = prefs.getString(_key);

    if (storedJson == null) return null;

    return WeatherPrognosis.fromJson(jsonDecode(storedJson));
  }

  @override
  Future<void> setWeather(WeatherPrognosis prognosis) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_key, jsonEncode(prognosis.toJson()));
  }
}
