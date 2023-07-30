import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_data_item.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDataItem extends Equatable{
  @JsonKey(name: "dt")
  final int dateEpochSeconds;
  final MainData main;
  final List<Weather> weather;
  final Clouds clouds;
  final Wind wind;
  final int visibility;
  final double pop;

  const WeatherDataItem(this.dateEpochSeconds, this.main, this.weather, this.clouds,
      this.visibility, this.wind, this.pop);

  factory WeatherDataItem.fromJson(Map<String, dynamic> json) =>
      _$WeatherDataItemFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherDataItemToJson(this);

  @override
  List<Object?> get props => [dateEpochSeconds];
}

@JsonSerializable(explicitToJson: true)
class MainData {
  @JsonKey(name: "temp")
  final double temperatureKelvin;
  @JsonKey(name: "feels_like")
  final double feelsLikeKelvin;
  @JsonKey(name: "temp_min")
  final double minTemp;
  @JsonKey(name: "temp_max")
  final double maxTemp;
  @JsonKey(name: "pressure")
  final double pressure;
  @JsonKey(name: "sea_level")
  final double seaLevelPressure;
  @JsonKey(name: "grnd_level")
  final double groundLevelPressure;
  @JsonKey(name: "humidity")
  final double humidity;
  @JsonKey(name: "temp_kf")
  final double tempKf;

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

  factory MainData.fromJson(Map<String, dynamic> json) =>
      _$MainDataFromJson(json);

  Map<String, dynamic> toJson() => _$MainDataToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;

  Weather(this.id, this.main, this.description, this.icon);

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Clouds {
  final int all;

  Clouds(this.all);

  factory Clouds.fromJson(Map<String, dynamic> json) => _$CloudsFromJson(json);

  Map<String, dynamic> toJson() => _$CloudsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Wind {
  final double speed;
  final double deg;
  final double gust;

  Wind(this.speed, this.deg, this.gust);

  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);
}
