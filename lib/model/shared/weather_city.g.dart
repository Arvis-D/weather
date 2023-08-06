// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

City _$CityFromJson(Map<String, dynamic> json) => City(
      json['id'] as int,
      json['name'] as String,
      Coordinates.fromJson(json['coord'] as Map<String, dynamic>),
      json['country'] as String,
      json['population'] as int,
      json['timezone'] as int,
      json['sunrise'] as int,
      json['sunset'] as int,
    );

Map<String, dynamic> _$CityToJson(City instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'coord': instance.coordinates.toJson(),
      'country': instance.country,
      'population': instance.population,
      'timezone': instance.timezone,
      'sunrise': instance.sunriseEpoch,
      'sunset': instance.sunsetEpoch,
    };
