import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends WeatherEvent {}

class WeatherBlocState extends Equatable {
  final bool isLoading;
  final String test;

  const WeatherBlocState({required this.isLoading, required this.test});

  WeatherBlocState copyWith({bool? isLoading}) =>
      WeatherBlocState(isLoading: isLoading ?? this.isLoading, test: "Rome");

  @override
  List<Object?> get props => [isLoading];
}

class WeatherBlock extends Bloc<WeatherEvent, WeatherBlocState> {
  WeatherBlock() : super(const WeatherBlocState(isLoading: false, test: "Ruum")) {
    on<InitEvent>(_initialize);
  }

  _initialize(InitEvent event, Emitter<WeatherBlocState> emit) {
    emit(state.copyWith(isLoading: true));
  }
}
