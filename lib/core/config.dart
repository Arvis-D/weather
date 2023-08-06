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
      const String.fromEnvironment("API_KEY", defaultValue: "");
}

enum Flavor { prod, stage }
