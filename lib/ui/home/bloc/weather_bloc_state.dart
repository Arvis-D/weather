import 'package:equatable/equatable.dart';

import '../../../model/local/weather_day.dart';
import '../../../model/local/weather_prognosis.dart';

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
