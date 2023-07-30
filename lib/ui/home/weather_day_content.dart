import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/ui/home/weather_data_item.dart';

import '../../model/local/weather_day.dart';

class WeatherDataForDay extends StatelessWidget {
  final WeatherDay? day;

  const WeatherDataForDay({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.topLeft,
      child: ListView.separated(
        itemBuilder: (context, index) =>
            WeatherDataItemWidget(item: day?.data[index]),
        itemCount: day?.data.length ?? 0,
        separatorBuilder: (context, index) {
          return Divider(thickness: 0.25, color: Theme.of(context).colorScheme.onBackground);
        },
      ),
    );
  }
}
