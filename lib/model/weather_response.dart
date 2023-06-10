import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/weather_data_item.dart';

part 'weather_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherResponse {
  @JsonKey(name: "cod")
  String? code;
  int? message;
  @JsonKey(name: "cnt")
  int? count;
  @JsonKey(name: "list")
  List<WeatherDataItem> weatherData;
  City city;

  WeatherResponse(
      this.code, this.message, this.count, this.weatherData, this.city);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class City {
  int id;
  String name;
  @JsonKey(name: "coord")
  Coordinates coordinates;
  String country;
  int population;
  int timezone;

  @JsonKey(name: "sunrise")
  int sunriseEpoch;
  @JsonKey(name: "sunset")
  int sunsetEpoch;

  City(this.id, this.name, this.coordinates, this.country, this.population,
      this.timezone, this.sunriseEpoch, this.sunsetEpoch);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Coordinates {
  final double lat;
  final double lon;

  Coordinates(this.lat, this.lon);

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);
  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);
}
