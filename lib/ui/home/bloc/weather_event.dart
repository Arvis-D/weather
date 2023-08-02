import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends WeatherEvent {}

class NexDay extends WeatherEvent {}

class PreviousDay extends WeatherEvent {}
