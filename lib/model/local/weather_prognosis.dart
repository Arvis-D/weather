import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/local/weather_day.dart';
import 'package:weather/model/shared/weather_city.dart';

part 'weather_prognosis.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherPrognosis {
  List<WeatherDay> days;
  City city;

  WeatherPrognosis(this.days, this.city);

  factory WeatherPrognosis.fromJson(Map<String, dynamic> json) => _$WeatherPrognosisFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherPrognosisToJson(this);
}
