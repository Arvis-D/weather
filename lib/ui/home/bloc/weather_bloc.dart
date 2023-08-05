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
    on<GoToNextDay>(_onNextDay);
    on<GoToPreviousDay>(_onPreviousDay);
    on<Refresh>(_refresh);
  }

  Future<void> _initialize(
    InitEvent event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(state.copyWith(prognosis: const DelayedResult.loading()));

    await _tryFetchWeather(emit, true);
  }

  Future<void> _refresh(
    Refresh event,
    Emitter<WeatherBlocState> emit,
  ) async {
    emit(
      state.copyWith(
        prognosis: DelayedResult.loading(value: state.prognosis.value),
      ),
    );

    await _tryFetchWeather(emit, false);
  }

  Future<void> _tryFetchWeather(
      Emitter<WeatherBlocState> emit, bool useSaved) async {
    try {
      final WeatherPrognosis prognosis =
          await getWeatherUseCase(useSaved: useSaved);

      emit(
        state.copyWith(
          selectedIdx: 0,
          hasNext: _idxValid(prognosis, 1),
          hasPrevious: false,
          prognosis: DelayedResult.fromValue(prognosis),
        ),
      );
    } on Exception catch (e) {
      state.copyWith(prognosis: DelayedResult.fromError(e));
    } catch (e) {
      Fimber.e("ERROR", ex: e);
    }
  }

  void _onNextDay(
    GoToNextDay event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _tryChangeSelectedIdx(emit, 1);
  }

  void _onPreviousDay(
    GoToPreviousDay event,
    Emitter<WeatherBlocState> emit,
  ) async {
    _tryChangeSelectedIdx(emit, -1);
  }

  void _tryChangeSelectedIdx(
    Emitter<WeatherBlocState> emit,
    int change,
  ) async {
    final int newIdx = state.selectedIdx + change;

    if (!_idxValid(state.prognosis.value, newIdx)) return;

    emit(state.copyWith(
      prognosis: null,
      selectedIdx: newIdx,
      hasNext: _idxValid(state.prognosis.value, newIdx + 1),
      hasPrevious: _idxValid(state.prognosis.value, newIdx - 1),
    ));
  }

  bool _idxValid(WeatherPrognosis? prognosis, int idx) {
    final int lastIdx = (prognosis?.days.length ?? 0) - 1;

    return idx >= 0 && idx <= lastIdx;
  }
}
