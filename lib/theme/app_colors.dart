import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.success,
    required this.warning,
    required this.mapStart,
    required this.mapEnd,
  });

  final Color success;
  final Color warning;
  final Color mapStart;
  final Color mapEnd;

  static const light = AppColors(
    success: Color(0xFF2E7D32),
    warning: Color(0xFF9A5B00),
    mapStart: Color(0xFFFFFFFF),
    mapEnd: Color(0xFFFF6D00),
  );

  static const dark = AppColors(
    success: Color(0xFF81C784),
    warning: Color(0xFFFFB74D),
    mapStart: Color(0xFFFFFFFF),
    mapEnd: Color(0xFFFFB74D),
  );

  @override
  AppColors copyWith({
    Color? success,
    Color? warning,
    Color? mapStart,
    Color? mapEnd,
  }) {
    return AppColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      mapStart: mapStart ?? this.mapStart,
      mapEnd: mapEnd ?? this.mapEnd,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      mapStart: Color.lerp(mapStart, other.mapStart, t)!,
      mapEnd: Color.lerp(mapEnd, other.mapEnd, t)!,
    );
  }
}

extension AppThemeContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
