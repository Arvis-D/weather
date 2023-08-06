import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:weather/core/config.dart';
import 'package:weather/di/provider.dart';
import 'package:weather/use_case/get_location.dart';
import 'package:weather/use_case/get_weather.dart';

import '../repository/weather_prognosis_preferences_repository.dart';
import '../repository/weather_prognosis_repository.dart';
import '../service/api/weather_api.dart';

class DI {
  static final Provider<Dio> dio = Provider(() {
    final Dio dio = Dio();

    if (Config.getFlavor() != Flavor.prod) {
      // Todo: to use this I have to use an older version of dio so find a better solution
      dio.interceptors.add(
        DioLoggingInterceptor(
          level: Level.body,
          compact: false,
        ),
      );
    }

    return dio;
  });

  static final Provider<WeatherApi> weatherApi =
      Provider(() => WeatherApi(dio.get()));

  static final Provider<WeatherPrognosisRepository> weatherResponseRepository =
      Provider(() => WeatherPrognosisPreferencesRepository());

  static final Provider<GetPositionUseCase> getPositionUseCase =
      Provider(() => GetPositionUseCase());

  static final Provider<GetWeatherUseCase> getWeatherUseCase = Provider(
    () => GetWeatherUseCase(
      weatherApi: weatherApi.get(),
      weatherPrognosisRepository: weatherResponseRepository.get(),
      getPositionUseCase: getPositionUseCase.get(),
    ),
  );
}
