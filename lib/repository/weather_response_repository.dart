import 'package:weather/model/local/weather_prognosis.dart';

abstract class WeatherPrognosisRepository {
  Future<WeatherPrognosis> getWeather();
}
