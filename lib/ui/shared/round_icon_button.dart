import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final void Function() onClick;
  final IconData iconData;
  final bool visible;
  final bool enabled;

  const RoundIconButton({
    super.key,
    required this.onClick,
    required this.iconData,
    this.visible = true,
    this.enabled = true
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: ElevatedButton(
        onPressed: visible && enabled ? onClick : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(24),
        ),
        child: Icon(
          iconData,
          color: Theme.of(context).colorScheme.onPrimary,
          size: 24.0,
        ),
      ),
    );
  }
}
