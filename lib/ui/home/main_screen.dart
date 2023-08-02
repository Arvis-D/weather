import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/ui/home/day_switch.dart';
import 'package:weather/ui/home/bloc/weather_bloc.dart';
import 'package:weather/ui/home/weather_day_content.dart';

import '../../di/dependencies.dart';
import 'bloc/weather_bloc_state.dart';
import 'bloc/weather_event.dart';
import 'location_header.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBloc(
        weatherRepo: DI.weatherResponseRepository.get(),
      )..add(InitEvent()),
      child: const MyHomePageContent(),
    );
  }
}

class MyHomePageContent extends StatelessWidget {
  const MyHomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherBlocState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
              child: Column(
                children: [
                  LocationHeader(city: state.prognosis?.city),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: WeatherDataForDay(
                        day: state.getSelectedDay(),
                      ),
                    ),
                  ),
                  DaySwitch(
                    dayName: state.getSelectedDay()?.dayName ?? "No day",
                    hasNext: state.hasNext,
                    hasPrevious: state.hasPrevious,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
