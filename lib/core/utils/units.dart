import 'package:pedali/l10n/app_localizations.dart';

enum UnitSystem { metric, imperial }

extension UnitSystemFormat on UnitSystem {
  String formatDistance(double meters, AppLocalizations t) {
    if (this == UnitSystem.imperial) {
      final miles = meters / 1609.344;
      return '${miles.toStringAsFixed(1)} ${t.mileUnit}';
    }

    final kilometers = meters / 1000;
    return '${kilometers.toStringAsFixed(1)} ${t.kilometerUnit}';
  }

  String formatSpeed(double mps, AppLocalizations t) {
    if (this == UnitSystem.imperial) {
      final mph = mps * 2.23694;
      return '${mph.toStringAsFixed(1)} ${t.milesPerHourUnit}';
    }

    final kmh = mps * 3.6;
    return '${kmh.toStringAsFixed(1)} ${t.kilometersPerHourUnit}';
  }
}
