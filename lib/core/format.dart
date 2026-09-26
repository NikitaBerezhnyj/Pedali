String formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  if (h > 0) return '${h}h ${m}m';
  final s = d.inSeconds.remainder(60);
  return '${m}m ${s}s';
}
