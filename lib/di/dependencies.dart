import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:weather/di/provider.dart';
import 'package:weather/repository/weather_response_repository_impl.dart';

import '../api/weather_api.dart';
import '../repository/weather_response_repository.dart';

class DI {
  static final Provider<Dio> dio = Provider(() {
    final Dio dio = Dio();
    // Todo: to use this I have to use older dio version so find a better solution
    dio.interceptors.add(DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ));
    return dio;
  });

  static final Provider<WeatherApi> weatherApi =
      Provider(() => WeatherApi(dio.get()));

  static final Provider<WeatherResponseRepository> weatherResponseRepository =
      Provider(() => WeatherResponseRepositoryImpl(weatherApi.get()));
}
