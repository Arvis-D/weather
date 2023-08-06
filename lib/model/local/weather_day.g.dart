// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDay _$WeatherDayFromJson(Map<String, dynamic> json) => WeatherDay(
      (json['data'] as List<dynamic>)
          .map((e) => WeatherDataItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['dayName'] as String,
    );

Map<String, dynamic> _$WeatherDayToJson(WeatherDay instance) =>
    <String, dynamic>{
      'data': instance.data.map((e) => e.toJson()).toList(),
      'dayName': instance.dayName,
    };
