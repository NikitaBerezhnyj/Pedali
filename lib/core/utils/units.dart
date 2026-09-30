enum UnitSystem { metric, imperial }

extension UnitSystemFormat on UnitSystem {
  String formatDistance(double meters) {
    if (this == UnitSystem.imperial) {
      final miles = meters / 1609.344;
      return '${miles.toStringAsFixed(1)} mi';
    }
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  String formatSpeed(double mps) {
    if (this == UnitSystem.imperial) {
      final mph = mps * 2.23694;
      return '${mph.toStringAsFixed(1)} mph';
    }
    return '${(mps * 3.6).toStringAsFixed(1)} km/h';
  }
}
