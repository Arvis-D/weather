import 'package:equatable/equatable.dart';
import 'package:weather/core/delayed_result.dart';

import '../../../model/local/weather_day.dart';
import '../../../model/local/weather_prognosis.dart';

class WeatherBlocState extends Equatable {
  final DelayedResult<WeatherPrognosis> prognosis;
  final int selectedIdx;
  final bool hasNext;
  final bool hasPrevious;

  const WeatherBlocState({
    required this.prognosis,
    required this.selectedIdx,
    required this.hasPrevious,
    required this.hasNext,
  });

  WeatherBlocState copyWith({
    DelayedResult<WeatherPrognosis>? prognosis,
    int? selectedIdx,
    bool? hasNext,
    bool? hasPrevious,
  }) =>
      WeatherBlocState(
        prognosis: prognosis ?? this.prognosis,
        selectedIdx: selectedIdx ?? this.selectedIdx,
        hasNext: hasNext ?? this.hasNext,
        hasPrevious: hasPrevious ?? this.hasPrevious,
      );

  static WeatherBlocState initialState() => const WeatherBlocState(
    prognosis: DelayedResult.loading(),
    selectedIdx: 0,
    hasPrevious: false,
    hasNext: true,
  );

  WeatherDay? getSelectedDay() {
    return prognosis.value?.days.elementAtOrNull(selectedIdx);
  }

  @override
  List<Object?> get props =>
      [prognosis, hasPrevious, hasNext, selectedIdx];
}
