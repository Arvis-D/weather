import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/ui/home/bloc/weather_bloc.dart';

import '../shared/round_icon_button.dart';
import 'bloc/weather_event.dart';

class DaySwitch extends StatelessWidget {
  final String dayName;
  final bool hasNext;
  final bool hasPrevious;

  const DaySwitch({
    super.key,
    required this.dayName,
    required this.hasNext,
    required this.hasPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final WeatherBloc bloc = BlocProvider.of<WeatherBloc>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.all(8),
          child: RoundIconButton(
            onClick: () => bloc.add(GoToPreviousDay()),
            visible: hasPrevious,
            iconData: Icons.arrow_back_ios,
          ),
        ),
        Expanded(
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(64),
                topRight: Radius.circular(64),
              ),
            ),
            child: Center(
              child: Text(
                dayName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          child: RoundIconButton(
            onClick: () => bloc.add(GoToNextDay()),
            visible: hasNext,
            iconData: Icons.arrow_forward_ios,
          ),
        ),
      ],
    );
  }
}
