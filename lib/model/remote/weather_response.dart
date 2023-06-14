import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/shared/weather_data_item.dart';

import '../shared/weather_city.dart';

part 'weather_response.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherResponse {
  @JsonKey(name: "cod")
  final String? code;
  final int? message;
  @JsonKey(name: "cnt")
  final int? count;
  @JsonKey(name: "list")
  final List<WeatherDataItem> weatherData;
  final City city;

  WeatherResponse(
      this.code, this.message, this.count, this.weatherData, this.city);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) => _$WeatherResponseFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);
}
