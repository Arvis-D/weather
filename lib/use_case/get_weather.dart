import 'package:geolocator/geolocator.dart';
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

  Future<WeatherPrognosis> call({bool shouldRefresh = false}) async {
    Position position = await getPositionUseCase();

    return weatherApi
        .fetchWeatherData(position.latitude, position.longitude)
        .then((response) {
      WeatherPrognosis prognosis =
          WeatherPrognosisMapper.fromWeatherResponse(response);
      weatherPrognosisRepository.setWeather(prognosis);
      return prognosis;
    });
  }
}
