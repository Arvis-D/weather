import 'package:weather/model/weather_response.dart';

abstract class WeatherResponseRepository {
  Future<WeatherResponse> getWeather();
}
