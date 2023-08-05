import 'package:flutter/material.dart';

class WeatherProgressIndicator extends StatefulWidget {
  const WeatherProgressIndicator({super.key});

  @override
  State<WeatherProgressIndicator> createState() => _WeatherProgressIndicatorState();
}

class _WeatherProgressIndicatorState extends State<WeatherProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: CircularProgressIndicator(
        strokeWidth: 5,
        value: controller.value,
        semanticsLabel: 'Circular progress indicator',
      ),
    );
  }
}
