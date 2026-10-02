import 'package:flutter/material.dart';

abstract final class AppTheme {
  static const seed = Colors.orange;

  static final light = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: Brightness.light,
  );

  static final dark = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: seed,
    brightness: Brightness.dark,
  );
}
