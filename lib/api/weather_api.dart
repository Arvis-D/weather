import 'package:dio/dio.dart';
import 'package:weather/env.dart';

import '../model/remote/weather_response.dart';

class WeatherApi {
  final Dio dio;
  static const String _baseUrl =
      "https://api.openweathermap.org/data/2.5/forecast";

  WeatherApi(this.dio);

  Future<WeatherResponse> fetchWeatherData() async {
    Response response = await dio.get(
      _baseUrl,
      queryParameters: {
        'appid': Env.weatherApiKey,
        'lat': '41.9028',
        'lon': '12.4964'
      },
    );

    return WeatherResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
