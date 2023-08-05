import 'package:flutter/material.dart';

import '../../../core/config.dart';
import '../../../model/shared/weather_data_item.dart';

class WeatherIconHero extends StatelessWidget {
  final WeatherDataItem? item;
  static const String tag = "WeatherIconHero";

  String _getTag() => "WeatherIconHero+${item?.dateEpochSeconds}";

  const WeatherIconHero({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _getTag(),
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primary),
        child: Image.network(
          width: 50,
          height: 50,
          item?.weather.firstOrNull?.getIconUrl() ?? Config.defaultIconUrl,
        ),
      ),
    );
  }
}
