import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/ui/home/day_switch.dart';
import 'package:weather/ui/home/bloc/weather_bloc.dart';
import 'package:weather/ui/home/weather_day_content.dart';
import 'package:weather/ui/shared/round_icon_button.dart';

import '../../core/ui/widget/progress_indicator.dart';
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
        getWeatherUseCase: DI.getWeatherUseCase.get(),
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
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                  child: Column(
                    children: [
                      LocationHeader(city: state.prognosis.value?.city),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(top: 16),
                          child: _getContent(state),
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Transform.translate(
                    offset: const Offset(0, -64 - 8),
                    child: RoundIconButton(
                      enabled: !state.prognosis.loading,
                      iconData: Icons.replay,
                      onClick: () =>
                          BlocProvider.of<WeatherBloc>(context).add(Refresh()),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Todo: create error state
  Widget _getContent(WeatherBlocState state) {
    if (state.prognosis.loading) {
      return const Center(
        child: WeatherProgressIndicator(),
      );
    }

    return WeatherDataForDay(
      day: state.getSelectedDay(),
    );
  }
}
