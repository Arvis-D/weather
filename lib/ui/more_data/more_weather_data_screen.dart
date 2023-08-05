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
              Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _Header(item: item)),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: _Content(
                      item: item,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final WeatherDataItem? item;

  const _Header({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
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
            WeatherTimeHero(
              item: item,
              textStyle: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: WeatherDescriptionHero(
                    item: item,
                    needsUnderline: false,
                  ),
                ),
              ],
            ),
            WeatherIconHero(item: item),
          ],
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final WeatherDataItem? item;
  final List<_InfoPair> _info;

  _Content({required this.item})
      : _info = [
          _InfoPair(name: "Visibility", value: "${item?.visibility} m"),
          _InfoPair(name: "Wind speed", value: "${item?.wind.speed} m/s"),
          _InfoPair(name: "Wind speed Gusts", value: "${item?.wind.gust} m/s"),
          _InfoPair(name: "Wind direction", value: "${item?.wind.deg}°"),
          _InfoPair(name: "Feels like temp", value: "${item?.main.feelsLikeKelvin}"),
          _InfoPair(name: "Temperature", value: "${item?.main.temperatureKelvin}"),
          _InfoPair(name: "Max temp", value: "${item?.main.maxTemp}"),
          _InfoPair(name: "Min temp", value: "${item?.main.minTemp}"),
          _InfoPair(name: "Humidity", value: "${item?.main.humidity}%"),
          _InfoPair(name: "Ground lvl pressure", value: "${item?.main.groundLevelPressure} hPa"),
          _InfoPair(name: "Sea lvl pressure", value: "${item?.main.seaLevelPressure} hPa"),
          _InfoPair(name: "Pressure", value: "${item?.main.pressure} hPa"),
        ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.topLeft,
      child: ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, idx) => _InfoPairWidget(pair: _info[idx]),
        separatorBuilder: (context, _) {
          return Container(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Divider(
                thickness: 0.25,
                color: Theme.of(context).colorScheme.onBackground),
          );
        },
        itemCount: _info.length,
      ),
    );
  }
}

class _InfoPair {
  final String name;
  final String value;

  const _InfoPair({required this.name, required this.value});
}

class _InfoPairWidget extends StatelessWidget {
  final _InfoPair pair;

  const _InfoPairWidget({required this.pair});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          pair.name,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Text(
          pair.value,
          maxLines: 1,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        )
      ],
    );
  }
}
