import 'package:intl/intl.dart';
import 'package:pedali/l10n/app_localizations.dart';

String formatDuration(Duration duration, AppLocalizations t) {
  final h = duration.inHours;
  final m = duration.inMinutes.remainder(60);
  final s = duration.inSeconds.remainder(60);

  if (h > 0) {
    return '${h}${t.hourShort} ${m}${t.minuteShort}';
  }

  return '${m}${t.minuteShort} ${s}${t.secondShort}';
}

String formatStartedAt(
  int startedAtMs, {
  required String locale,
  bool includeTime = false,
}) {
  final dt = DateTime.fromMillisecondsSinceEpoch(
    startedAtMs,
    isUtc: true,
  ).toLocal();

  final formatter = includeTime
      ? DateFormat.yMd(locale).add_Hm()
      : DateFormat.yMd(locale);

  return formatter.format(dt);
}
