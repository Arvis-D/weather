import 'package:dio/dio.dart';
import 'package:weather/core/env.dart';

import '../../model/remote/weather_response.dart';

class WeatherApi {
  final Dio dio;
  static const String _baseUrl =
      "https://api.openweathermap.org/data/2.5/forecast";

  WeatherApi(this.dio);

  Future<WeatherResponse> fetchWeatherData(
    double latitude,
    double longitude,
  ) async {
    Response response = await dio.get(
      _baseUrl,
      queryParameters: {
        'appid': Env.weatherApiKey,
        'lat': latitude,
        'lon': longitude,
        'units': "metric"
      },
    );

    return WeatherResponse.fromJson(response.data as Map<String, dynamic>);
  }
}
