import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../../model/shared/weather_data_item.dart';

class WeatherDataItemWidget extends StatelessWidget {
  final WeatherDataItem? item;

  const WeatherDataItemWidget({required this.item});

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
