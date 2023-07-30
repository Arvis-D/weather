import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData.light().copyWith(
  colorScheme: ThemeData.light().colorScheme.copyWith(
    background: const Color.fromARGB(255, 18, 130, 162),
    primary: const Color.fromARGB(255, 159, 226, 244),
    onPrimary: Colors.black,
    onBackground: const Color.fromARGB(255, 223, 245, 251)
  )
);

final ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.red,
  // Add other styling properties as you need
);
