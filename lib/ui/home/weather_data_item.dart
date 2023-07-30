import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/service/api/weather_api.dart';

import '../../model/shared/weather_data_item.dart';

class WeatherDataItemWidget extends StatelessWidget {
  final WeatherDataItem? item;

  const WeatherDataItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _getTime(item),
          maxLines: 1,
          overflow: TextOverflow.fade,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              child: Text(
                item?.weather.firstOrNull?.description ?? "no weather",
                maxLines: 1,
                overflow: TextOverflow.fade,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary
              ),
              child: Image.network(
                width: 50,
                height: 50,
                item?.weather.firstOrNull?.getIconUrl() ??
                    WeatherApi.defaultIconUrl,
              ),
            )
          ],
        ),
      ],
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
