// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      json['cod'] as String?,
      json['message'] as int?,
      json['cnt'] as int?,
      (json['list'] as List<dynamic>)
          .map((e) => WeatherDataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'cod': instance.code,
      'message': instance.message,
      'cnt': instance.count,
      'list': instance.weatherData.map((e) => e.toJson()).toList(),
      'city': instance.city.toJson(),
    };
