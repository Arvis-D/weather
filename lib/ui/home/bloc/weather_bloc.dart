import 'package:fimber/fimber.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/delayed_result.dart';
import 'package:weather/model/local/weather_prognosis.dart';
import 'package:weather/ui/home/bloc/weather_bloc_state.dart';
import 'package:weather/ui/home/bloc/weather_event.dart';

import '../../../use_case/get_weather.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherBlocState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc({
    required this.getWeatherUseCase,
  }) : super(WeatherBlocState.initialState()) {
    on<InitEvent>(_initialize);
    on<NexDay>(_onNextDay);
    on<PreviousDay>(_onPreviousDay);
  }

  Future<void> _initialize(
    InitEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(state.copyWith(prognosis: const DelayedResult.loading()));

    try {
      final WeatherPrognosis prognosis = await getWeatherUseCase();

      emit(state.copyWith(prognosis: DelayedResult.fromValue(prognosis)));
    } on Exception catch (e) {
      state.copyWith(prognosis: DelayedResult.fromError(e));
    } catch (e) {
      Fimber.e("ERROR", ex: e);
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
    final int lastIdx = (state.prognosis.value?.days.length ?? 0) - 1;

    return idx >= 0 && idx <= lastIdx;
  }
}
