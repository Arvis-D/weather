import 'package:dio/dio.dart';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';
import 'package:weather/env.dart';

class WeatherApi {
  static final Dio dio = _createDio();
  static const String _baseUrl =
      "https://api.openweathermap.org/data/2.5/forecast";

  static getWeatherData() async {
    final Response response = await dio.get(
      _baseUrl,
      queryParameters: {
        'appid': Env.weatherApiKey,
        'lat': '41.9028',
        'lon': '12.4964'
      },
    );
  }

  static Dio _createDio() {
    final dio = Dio();

    // Todo: to use this I have to use older dio version so find a better solution
    dio.interceptors.add(DioLoggingInterceptor(
      level: Level.body,
      compact: false,
    ));

    return dio;
  }
}
