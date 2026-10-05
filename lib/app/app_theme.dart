import 'package:flutter/material.dart';
import 'package:pedali/theme/app_colors.dart';
import 'package:pedali/theme/app_tokens.dart';

abstract final class AppTheme {
  static const seed = Colors.orange;
  static final brand = seed.shade800;

  static final light = _build(Brightness.light);
  static final dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    ).copyWith(primary: brand, onPrimary: Colors.white);
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);
    final tt = base.textTheme;

    final textTheme = tt.copyWith(
      headlineSmall: tt.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: tt.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: tt.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      titleSmall: tt.titleSmall?.copyWith(fontWeight: FontWeight.w600),
    );

    final buttonShape = RoundedRectangleBorder(borderRadius: AppRadius.lg);
    const buttonSize = Size(0, 52);

    return base.copyWith(
      textTheme: textTheme,
      extensions: [
        brightness == Brightness.light ? AppColors.light : AppColors.dark,
      ],
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        scrolledUnderElevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: buttonSize,
          shape: buttonShape,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: buttonSize,
          shape: buttonShape,
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: AppRadius.md),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xlValue),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: AppRadius.md),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
