import 'package:flutter/material.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/utils/format.dart';
import 'package:pedali/features/rides/screens/ride_detail_screen.dart';

class RecordCard extends StatelessWidget {
  const RecordCard({
    super.key,
    required this.icon,
    required this.label,
    required this.ride,
    required this.valueBuilder,
  });

  final IconData icon;
  final String label;
  final Ride? ride;
  final String Function(Ride ride) valueBuilder;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final r = ride;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: r == null
            ? null
            : () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RideDetailScreen(rideId: r.id),
                ),
              ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          child: r == null
              ? Row(
                  children: [
                    Icon(icon, color: cs.primary, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        label,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Text('—'),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        Icon(icon, color: cs.primary, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            label,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const SizedBox(width: 32),
                        Expanded(
                          child: Text(
                            formatStartedAt(r.startedAt),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.textTheme.bodySmall?.color
                                  ?.withValues(alpha: 0.6),
                            ),
                          ),
                        ),
                        Text(
                          valueBuilder(r),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 2),
                        Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: cs.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
