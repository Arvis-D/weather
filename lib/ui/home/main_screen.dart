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
                  )
                ),
                SizedBox(
                  height: 100,
                  child: _DaySelector(
                    days: state.prognosis?.days ?? [],
                    selectedIdx: state.selectedIdx,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class _DaySelector extends StatelessWidget {
  final List<WeatherDay> days;
  final int? selectedIdx;

  const _DaySelector({required this.days, required this.selectedIdx});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      color: Colors.purple,
      alignment: Alignment.topLeft,
      child: ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _DaySelectorItem(
          isSelected: index == selectedIdx,
          dayName: days[index].dayName,
          onSelected: (index) {},
        ),
        itemCount: days.length,
        separatorBuilder: (context, index) {
          return const Divider(thickness: 1, color: Colors.black);
        },
      ),
    );
  }
}

class _DaySelectorItem extends StatelessWidget {
  final bool isSelected;
  final Function(int) onSelected;
  final String dayName;

  const _DaySelectorItem({
    required this.isSelected,
    required this.dayName,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.yellow,
      alignment: Alignment.topLeft,
      child: Center(
        child: OutlinedButton(
          child: Text(
            dayName,
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          onPressed: (){},
        ),
      ),
    );
  }
}
