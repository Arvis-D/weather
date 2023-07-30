import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/ui/home/weather_bloc.dart';

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
          child: _RoundButton(onClick: () {}, isLeft: true),
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
          child: _RoundButton(onClick: () {}, isLeft: false),
        ),
      ],
    );
  }
}

class _RoundButton extends StatelessWidget {
  final void Function() onClick;
  final bool isLeft;

  const _RoundButton({required this.onClick, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
      ),
      child: Icon(
        isLeft ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
        color: Theme.of(context).colorScheme.onPrimary,
        size: 24.0,
      ),
    );
  }
}
