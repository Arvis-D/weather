import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends WeatherEvent {}

class GoToNextDay extends WeatherEvent {}

class GoToPreviousDay extends WeatherEvent {}

class Refresh extends WeatherEvent {}
