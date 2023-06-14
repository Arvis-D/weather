import 'package:json_annotation/json_annotation.dart';
import 'package:weather/model/shared/weather_data_item.dart';

part 'weather_day.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherDay {
  List<WeatherDataItem> data;
  String dayName;

  WeatherDay(this.data, this.dayName);

  factory WeatherDay.fromJson(Map<String, dynamic> json) => _$WeatherDayFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDayToJson(this);
}
