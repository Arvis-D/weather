import 'package:flutter/material.dart';
import 'package:weather/model/shared/weather_data_item.dart';

class WeatherDescriptionHero extends StatelessWidget {
  final WeatherDataItem? item;
  final bool needsUnderline;

  const WeatherDescriptionHero({
    super.key,
    required this.item,
    this.needsUnderline = true,
  });

  String _getTag() => "WeatherDescriptionHero+${item?.dateEpochSeconds}";

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _getTag(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            item?.main.temperatureKelvin.asDegrees() ?? "",
            maxLines: 1,
            overflow: TextOverflow.fade,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: needsUnderline
                      ? Theme.of(context).colorScheme.onBackground
                      : Colors.transparent,
                ),
              ),
            ),
            child: Text(
              item?.weather.firstOrNull?.description ?? "",
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
        ],
      ),
    );
  }
}
