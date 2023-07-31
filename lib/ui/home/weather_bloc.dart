import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/model/local/weather_day.dart';
import 'package:weather/model/local/weather_prognosis.dart';

import '../../repository/weather_response_repository.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object?> get props => [];
}

class InitEvent extends WeatherEvent {}

class NexDay extends WeatherEvent {}

class PreviousDay extends WeatherEvent {}

class WeatherBlocState extends Equatable {
  final bool isLoading;
  final WeatherPrognosis? prognosis;
  final int selectedIdx;
  final bool hasNext;
  final bool hasPrevious;

  const WeatherBlocState({
    required this.isLoading,
    required this.prognosis,
    required this.selectedIdx,
    required this.hasPrevious,
    required this.hasNext,
  });

  WeatherBlocState copyWith({
    bool? isLoading,
    WeatherPrognosis? prognosis,
    int? selectedIdx,
    bool? hasNext,
    bool? hasPrevious,
  }) =>
      WeatherBlocState(
        isLoading: isLoading ?? this.isLoading,
        prognosis: prognosis ?? this.prognosis,
        selectedIdx: selectedIdx ?? this.selectedIdx,
        hasNext: hasNext ?? this.hasNext,
        hasPrevious: hasPrevious ?? this.hasPrevious,
      );

  static WeatherBlocState initialState() => const WeatherBlocState(
        isLoading: false,
        prognosis: null,
        selectedIdx: 0,
        hasPrevious: false,
        hasNext: true,
      );

  WeatherDay? getSelectedDay() {
    return prognosis?.days.elementAtOrNull(selectedIdx);
  }

  @override
  List<Object?> get props =>
      [isLoading, prognosis, hasPrevious, hasNext, selectedIdx];
}

class WeatherBloc extends Bloc<WeatherEvent, WeatherBlocState> {
  WeatherPrognosisRepository weatherRepo;

  WeatherBloc({
    required this.weatherRepo,
  }) : super(WeatherBlocState.initialState()) {
    on<InitEvent>(_initialize);
    on<NexDay>(_onNextDay);
    on<PreviousDay>(_onPreviousDay);
  }

  Future<void> _initialize(
    InitEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    Fimber.d("ARVIS_DEBUG initialize");

    try {
      WeatherPrognosis prognosis = await weatherRepo.getWeather();

      emit(
        state.copyWith(isLoading: false, prognosis: prognosis),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _onNextDay(
    NexDay event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _tryChangeSelectedIdx(emit, 1);
  }

  Future<void> _onPreviousDay(
    PreviousDay event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _tryChangeSelectedIdx(emit, -1);
  }

  Future<void> _tryChangeSelectedIdx(
    Emitter<WeatherBlocState> emit,
    int change,
  ) async {
    final int newIdx = state.selectedIdx + change;

    if (!_idxValid(newIdx)) return;

    emit(state.copyWith(
      prognosis: null,
      selectedIdx: newIdx,
      hasNext: _idxValid(newIdx + 1),
      hasPrevious: _idxValid(newIdx - 1),
    ));
  }

  bool _idxValid(int idx) {
    final int lastIdx = (state.prognosis?.days.length ?? 0) - 1;

    if (idx < 0 || idx > lastIdx) return false;

    return true;
  }
}
