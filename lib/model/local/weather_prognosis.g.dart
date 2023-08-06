// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_prognosis.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherPrognosis _$WeatherPrognosisFromJson(Map<String, dynamic> json) =>
    WeatherPrognosis(
      (json['days'] as List<dynamic>)
          .map((e) => WeatherDay.fromJson(e as Map<String, dynamic>))
          .toList(),
      City.fromJson(json['city'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherPrognosisToJson(WeatherPrognosis instance) =>
    <String, dynamic>{
      'days': instance.days.map((e) => e.toJson()).toList(),
      'city': instance.city.toJson(),
    };
