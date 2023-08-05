import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../model/shared/weather_data_item.dart';

class WeatherTimeHero extends StatelessWidget {
  final WeatherDataItem? item;
  String _getTag() => "WeatherTimeHero+${item?.dateEpochSeconds}";

  const WeatherTimeHero({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _getTag(),
      child: Text(
        _getTime(item),
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }

  String _getTime(WeatherDataItem? item) {
    if (item == null) return "";

    final DateFormat formatter = DateFormat('Hm');

    DateTime time =
    DateTime.fromMillisecondsSinceEpoch(item.dateEpochSeconds * 1000)
        .toLocal();

    return formatter.format(time);
  }
}
