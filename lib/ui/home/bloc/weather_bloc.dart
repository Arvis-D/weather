import 'dart:developer';

import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/model/local/weather_prognosis.dart';
import 'package:weather/ui/home/bloc/weather_bloc_state.dart';
import 'package:weather/ui/home/bloc/weather_event.dart';

import '../../../repository/weather_response_repository.dart';

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

  void _onNextDay(
    NexDay event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _tryChangeSelectedIdx(emit, 1);
  }

  void _onPreviousDay(
    PreviousDay event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _tryChangeSelectedIdx(emit, -1);
  }

  void _tryChangeSelectedIdx(
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

    return idx >= 0 && idx <= lastIdx;
  }
}
