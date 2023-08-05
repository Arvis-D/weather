import 'package:flutter/material.dart';
import 'package:weather/ui/more_data/more_weather_data_screen.dart';
import 'package:weather/ui/shared/weather/description_hero.dart';
import 'package:weather/ui/shared/weather/icon_hero.dart';
import 'package:weather/ui/shared/weather/time_hero.dart';

import '../../model/shared/weather_data_item.dart';

class WeatherDataItemWidget extends StatelessWidget {
  final WeatherDataItem? item;

  const WeatherDataItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WeatherTimeHero(
          item: item,
          textStyle: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MoreWeatherDataScreen(item: item),
              ),
            );
          },
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.only(right: 8),
                child: WeatherDescriptionHero(item: item),
              ),
              WeatherIconHero(item: item)
            ],
          ),
        ),
      ],
    );
  }
}
