import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/api/weather_api.dart';
import 'package:weather/model/weather_response.dart';
import 'package:weather/repository/weather_response_repository.dart';

class WeatherResponseRepositoryImpl implements WeatherResponseRepository {
  final WeatherApi _api;
  static const _prefKey = 'WEATHER_RESPONSE';

  WeatherResponseRepositoryImpl(this._api);

  @override
  Future<WeatherResponse> getWeather() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedJson = prefs.getString(_prefKey);

    if (storedJson == null) {
        return _api.fetchWeatherData().then((weatherData){
          prefs.setString(_prefKey, jsonEncode(weatherData.toJson()));
          return weatherData;
        });
    } else {
      return WeatherResponse.fromJson(jsonDecode(storedJson));
    }
  }
}
