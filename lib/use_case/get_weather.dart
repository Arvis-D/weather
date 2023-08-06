import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/model/remote/weather_response.dart';
import 'package:weather/repository/weather_prognosis_repository.dart';
import 'package:weather/service/api/weather_api.dart';
import 'package:weather/use_case/get_location.dart';

import '../mapper/weather_prognosis_mapper.dart';
import '../model/local/weather_prognosis.dart';

class GetWeatherUseCase {
  final WeatherPrognosisRepository weatherPrognosisRepository;
  final WeatherApi weatherApi;
  final GetPositionUseCase getPositionUseCase;

  GetWeatherUseCase({
    required this.weatherApi,
    required this.weatherPrognosisRepository,
    required this.getPositionUseCase,
  });

  Future<WeatherPrognosis> call({bool useSaved = true}) async {
    if (useSaved) {
      FirebaseAnalytics.instance.logEvent(name: "using_saved_weather");

      final WeatherPrognosis? savedWeather =
        await weatherPrognosisRepository.getWeather();

      if (savedWeather != null) {
        return savedWeather;
      }
    }

    FirebaseAnalytics.instance.logEvent(name: "fetching_weather_from_api");
    final Position position = await getPositionUseCase();
    final WeatherResponse response = await weatherApi.fetchWeatherData(
      position.latitude,
      position.longitude,
    );
    final WeatherPrognosis prognosis =
        WeatherPrognosisMapper.fromWeatherResponse(response);

    weatherPrognosisRepository.setWeather(prognosis);

    return prognosis;
  }
}
