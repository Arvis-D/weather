import 'package:weather/mapper/weather_day_mapper.dart';
import 'package:weather/model/local/weather_prognosis.dart';
import 'package:weather/model/remote/weather_response.dart';

class WeatherPrognosisMapper {
  static WeatherPrognosis fromWeatherResponse(WeatherResponse response) {
    return WeatherPrognosis(
      WeatherDayMapper.fromWeatherDataItems(response.weatherData),
      response.city,
    );
  }
}
