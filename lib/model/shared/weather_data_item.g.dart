// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_data_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDataItem _$WeatherDataItemFromJson(Map<String, dynamic> json) =>
    WeatherDataItem(
      json['dt'] as int,
      MainData.fromJson(json['main'] as Map<String, dynamic>),
      (json['weather'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
      Clouds.fromJson(json['clouds'] as Map<String, dynamic>),
      json['visibility'] as int,
      Wind.fromJson(json['wind'] as Map<String, dynamic>),
      (json['pop'] as num).toDouble(),
    );

Map<String, dynamic> _$WeatherDataItemToJson(WeatherDataItem instance) =>
    <String, dynamic>{
      'dt': instance.dateEpochSeconds,
      'main': instance.main.toJson(),
      'weather': instance.weather.map((e) => e.toJson()).toList(),
      'clouds': instance.clouds.toJson(),
      'wind': instance.wind.toJson(),
      'visibility': instance.visibility,
      'pop': instance.pop,
    };

MainData _$MainDataFromJson(Map<String, dynamic> json) => MainData(
      (json['temp'] as num).toDouble(),
      (json['feels_like'] as num).toDouble(),
      (json['temp_max'] as num).toDouble(),
      (json['temp_min'] as num).toDouble(),
      (json['pressure'] as num).toDouble(),
      (json['sea_level'] as num).toDouble(),
      (json['grnd_level'] as num).toDouble(),
      (json['humidity'] as num).toDouble(),
      (json['temp_kf'] as num).toDouble(),
    );

Map<String, dynamic> _$MainDataToJson(MainData instance) => <String, dynamic>{
      'temp': instance.temperatureKelvin,
      'feels_like': instance.feelsLikeKelvin,
      'temp_min': instance.minTemp,
      'temp_max': instance.maxTemp,
      'pressure': instance.pressure,
      'sea_level': instance.seaLevelPressure,
      'grnd_level': instance.groundLevelPressure,
      'humidity': instance.humidity,
      'temp_kf': instance.tempKf,
    };

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      json['id'] as int,
      json['main'] as String,
      json['description'] as String,
      json['icon'] as String,
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

Clouds _$CloudsFromJson(Map<String, dynamic> json) => Clouds(
      json['all'] as int,
    );

Map<String, dynamic> _$CloudsToJson(Clouds instance) => <String, dynamic>{
      'all': instance.all,
    };

Wind _$WindFromJson(Map<String, dynamic> json) => Wind(
      (json['speed'] as num).toDouble(),
      (json['deg'] as num).toDouble(),
      (json['gust'] as num).toDouble(),
    );

Map<String, dynamic> _$WindToJson(Wind instance) => <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };
