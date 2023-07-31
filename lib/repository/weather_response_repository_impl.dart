import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/mapper/weather_prognosis_mapper.dart';
import 'package:weather/model/local/weather_prognosis.dart';
import 'package:weather/repository/weather_response_repository.dart';

import '../service/api/weather_api.dart';

class WeatherPrognosisRepositoryImpl implements WeatherPrognosisRepository {
  final WeatherApi _api;
  static const _prefKey = 'WEATHER_PROGNOSIS_2';

  WeatherPrognosisRepositoryImpl(this._api);

  @override
  Future<WeatherPrognosis> getWeather() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedJson = prefs.getString(_prefKey);

    if (storedJson == null) {
      return _api.fetchWeatherData().then((response) {
        WeatherPrognosis prognosis =
            WeatherPrognosisMapper.fromWeatherResponse(response);
        prefs.setString(_prefKey, jsonEncode(prognosis.toJson()));
        return prognosis;
      });
    } else {
      return WeatherPrognosis.fromJson(jsonDecode(storedJson));
    }
  }
}
