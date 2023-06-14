import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/model/local/weather_prognosis.dart';

import '../repository/weather_response_repository.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends WeatherEvent {}

class WeatherBlocState extends Equatable {
  final bool isLoading;
  final WeatherPrognosis? prognosis;

  const WeatherBlocState({required this.isLoading, required this.prognosis});

  WeatherBlocState copyWith({
    bool? isLoading,
    WeatherPrognosis? prognosis,
  }) =>
      WeatherBlocState(
        isLoading: isLoading ?? this.isLoading,
        prognosis: prognosis ?? this.prognosis,
      );

  static WeatherBlocState initialState() =>
      const WeatherBlocState(isLoading: false, prognosis: null);

  @override
  List<Object?> get props => [isLoading];
}

class WeatherBlock extends Bloc<WeatherEvent, WeatherBlocState> {
  WeatherPrognosisRepository weatherRepo;

  WeatherBlock({
    required this.weatherRepo,
  }) : super(WeatherBlocState.initialState()) {
    on<InitEvent>(_initialize);
  }

  Future<void> _initialize(
    InitEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    WeatherPrognosis prognosis = await weatherRepo.getWeather();

    emit(
      state.copyWith(
        isLoading: false,
        prognosis: prognosis
      ),
    );
  }
}
