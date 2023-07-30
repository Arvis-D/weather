import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/ui/home/weather_bloc.dart';
import 'package:weather/ui/home/weather_day_content.dart';

import '../../di/dependencies.dart';
import '../../model/local/weather_day.dart';
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
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  LocationHeader(city: state.prognosis?.city),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: WeatherDataForDay(
                        day: state.prognosis?.days.firstOrNull,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
