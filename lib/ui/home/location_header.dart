import 'package:flutter/material.dart';

import '../../model/shared/weather_city.dart';

class LocationHeader extends StatelessWidget {
  final City? city;

  const LocationHeader({super.key, required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
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
