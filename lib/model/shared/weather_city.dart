import 'package:json_annotation/json_annotation.dart';

import 'coordinates.dart';

part 'weather_city.g.dart';

@JsonSerializable(explicitToJson: true)
class City {
  final int id;
  final String name;
  @JsonKey(name: "coord")
  final Coordinates coordinates;
  final String country;
  final int population;
  final int timezone;

  @JsonKey(name: "sunrise")
  final int sunriseEpoch;
  @JsonKey(name: "sunset")
  final int sunsetEpoch;

  City(this.id, this.name, this.coordinates, this.country, this.population,
      this.timezone, this.sunriseEpoch, this.sunsetEpoch);

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);
  Map<String, dynamic> toJson() => _$CityToJson(this);
}
