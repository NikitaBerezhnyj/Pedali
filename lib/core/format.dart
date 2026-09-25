String formatDistance(double meters) =>
    '${(meters / 1000).toStringAsFixed(1)} km';

String formatSpeed(double mps) => '${(mps * 3.6).toStringAsFixed(1)} km/h';

String formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  if (h > 0) return '${h}h ${m}m';
  final s = d.inSeconds.remainder(60);
  return '${m}m ${s}s';
}
