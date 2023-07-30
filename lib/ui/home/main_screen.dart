import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/ui/home/weather_bloc.dart';
import 'package:weather/model/shared/weather_data_item.dart';
import 'package:collection/collection.dart';

import '../../di/dependencies.dart';
import '../../model/local/weather_day.dart';
import '../../model/shared/weather_city.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherBlock(
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
    return BlocBuilder<WeatherBlock, WeatherBlocState>(
        builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        //                    <--- top side
                        color: Colors.black,
                        width: 3.0,
                      ),
                    ),
                  ),
                  child: _LocationHeader(city: state.prognosis?.city),
                ),
                Expanded(
                  child: _WeatherDataForDay(
                    day: state.prognosis?.days.firstOrNull,
                  ),
                ),
                Container(
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

class _LocationHeader extends StatelessWidget {
  final City? city;

  const _LocationHeader({required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${city?.country}, ${city?.name ?? ""}",
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Text(
            city?.coordinates.toString() ?? "",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}

class _WeatherDataForDay extends StatelessWidget {
  final WeatherDay? day;

  const _WeatherDataForDay({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            _WeatherDataItem(item: day?.data[index]),
        itemCount: day?.data.length ?? 0,
        separatorBuilder: (context, index) {
          return const Divider(thickness: 1, color: Colors.black);
        },
      ),
    );
  }
}

class _WeatherDataItem extends StatelessWidget {
  final WeatherDataItem? item;

  const _WeatherDataItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _getTime(item),
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            item?.weather.firstOrNull?.description ?? "no weather",
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const Icon(Icons.add_box)
        ],
      ),
    );
  }

  String _getTime(WeatherDataItem? item) {
    if (item == null) return "";

    final DateFormat formatter = DateFormat('j');

    DateTime time =
        DateTime.fromMillisecondsSinceEpoch(item.dateEpochSeconds * 1000)
            .toLocal();

    return formatter.format(time);
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
