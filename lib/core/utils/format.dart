String formatDuration(Duration d) {
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  if (h > 0) return '${h}h ${m}m';
  final s = d.inSeconds.remainder(60);
  return '${m}m ${s}s';
}

String formatStartedAt(int startedAtMs, {bool includeTime = false}) {
  final dt = DateTime.fromMillisecondsSinceEpoch(
    startedAtMs,
    isUtc: true,
  ).toLocal();

  final date =
      '${dt.day.toString().padLeft(2, '0')}.'
      '${dt.month.toString().padLeft(2, '0')}.'
      '${dt.year}';

  if (!includeTime) {
    return date;
  }

  return '$date  '
      '${dt.hour.toString().padLeft(2, '0')}:'
      '${dt.minute.toString().padLeft(2, '0')}';
}
