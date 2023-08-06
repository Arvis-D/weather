import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  static const String weatherPrognosisSharedPreferencesKey =
      "WEATHER_PROGNOSIS";

  static const String defaultIconUrl =
      "https://openweathermap.org/img/wn/01d@2x.png";

  static const String _flavor =
      String.fromEnvironment('app.flavor', defaultValue: "stage");

  static Flavor getFlavor() => switch (_flavor) {
        "prod" => Flavor.prod,
        _ => Flavor.stage,
      };

  static String getApiKey() =>
      dotenv.env['WEATHER_API_KEY'] ?? "WEATHER_API_KEY";
}

enum Flavor { prod, stage }
