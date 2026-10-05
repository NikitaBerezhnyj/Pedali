import 'package:flutter/material.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/core/widgets/app_list_card.dart';
import 'package:pedali/features/rides/screens/ride_detail_screen.dart';

class RecordTile extends StatelessWidget {
  const RecordTile({
    super.key,
    required this.icon,
    required this.label,
    required this.ride,
    required this.valueBuilder,
    required this.locale,
  });

  final IconData icon;
  final String label;
  final Ride? ride;
  final String Function(Ride ride) valueBuilder;
  final String locale;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final r = ride;

    return AppListCard(
      leading: Icon(icon, color: cs.primary),
      title: label,
      subtitle: r == null ? null : formatStartedAt(r.startedAt, locale: locale),
      trailing: r == null
          ? const Text('—')
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(valueBuilder(r), style: theme.textTheme.titleMedium),
                Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
              ],
            ),
      onTap: r == null
          ? null
          : () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RideDetailScreen(rideId: r.id)),
            ),
    );
  }
}
