import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/utils/units.dart';
import 'package:pedali/features/map/domain/route_color_mode.dart';
import 'package:pedali/features/map/providers/route_color_mode_provider.dart';
import 'package:pedali/features/map/utils/speed_color_scale.dart';
import 'package:pedali/features/settings/providers/units_provider.dart';
import 'package:pedali/l10n/app_localizations.dart';

class SpeedLegend extends ConsumerWidget {
  const SpeedLegend({super.key, required this.scale});

  final SpeedColorScale scale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(routeColorModeProvider) == RouteColorMode.brand) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final t = AppLocalizations.of(context)!;
    final units = ref.watch(unitsProvider);
    final labelStyle = theme.textTheme.labelSmall?.copyWith(
      color: cs.onSurface,
      fontWeight: FontWeight.w600,
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(units.formatSpeed(scale.minMps, t), style: labelStyle),
          const SizedBox(width: 8),
          Container(
            width: 56,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              gradient: const LinearGradient(colors: SpeedColorScale.palette),
            ),
          ),
          const SizedBox(width: 8),
          Text(units.formatSpeed(scale.maxMps, t), style: labelStyle),
        ],
      ),
    );
  }
}
