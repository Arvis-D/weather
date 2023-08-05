import 'package:flutter/material.dart';
import 'package:weather/ui/shared/weather/description_hero.dart';
import 'package:weather/ui/shared/weather/icon_hero.dart';
import 'package:weather/ui/shared/weather/time_hero.dart';

import '../../model/shared/weather_data_item.dart';

class MoreWeatherDataScreen extends StatelessWidget {
  final WeatherDataItem? item;

  const MoreWeatherDataScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 16),
                            child: WeatherTimeHero(item: item),
                          ),
                          WeatherDescriptionHero(
                              item: item, needsUnderline: false)
                        ],
                      ),
                      WeatherIconHero(item: item)
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
