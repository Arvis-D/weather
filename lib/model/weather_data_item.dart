import 'package:json_annotation/json_annotation.dart';
part 'weather_data_item.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDataItem {
  @JsonKey(name: "dt")
  int dateEpoch;
  MainData main;
  List<Weather> weather;
  Clouds clouds;
  Wind wind;
  int visibility;
  double pop;

  WeatherDataItem(this.dateEpoch, this.main, this.weather, this.clouds,
      this.visibility, this.wind, this.pop);

  factory WeatherDataItem.fromJson(Map<String, dynamic> json) => _$WeatherDataItemFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDataItemToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MainData {
  @JsonKey(name: "temp")
  double temperatureKelvin;
  @JsonKey(name: "feels_like")
  double feelsLikeKelvin;
  @JsonKey(name: "temp_min")
  double minTemp;
  @JsonKey(name: "temp_max")
  double maxTemp;
  @JsonKey(name: "pressure")
  double pressure;
  @JsonKey(name: "sea_level")
  double seaLevelPressure;
  @JsonKey(name: "grnd_level")
  double groundLevelPressure;
  @JsonKey(name: "humidity")
  double humidity;
  @JsonKey(name: "temp_kf")
  double tempKf;

  MainData(
      this.temperatureKelvin,
      this.feelsLikeKelvin,
      this.maxTemp,
      this.minTemp,
      this.pressure,
      this.seaLevelPressure,
      this.groundLevelPressure,
      this.humidity,
      this.tempKf);

  factory MainData.fromJson(Map<String, dynamic> json) => _$MainDataFromJson(json);
  Map<String, dynamic> toJson() => _$MainDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Weather {
  int id;
  String main;
  String description;
  String icon;

  Weather(this.id, this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Clouds {
  int all;

  Clouds(this.all);

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);
  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Wind {
  double speed;
  double deg;
  double gust;

  Wind(this.speed, this.deg, this.gust);

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);
  Map<String, dynamic> toJson() => _$WindToJson(this);
}
