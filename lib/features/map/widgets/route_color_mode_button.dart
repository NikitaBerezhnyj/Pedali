import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/widgets/app_circle_button.dart';
import 'package:pedali/features/map/domain/route_color_mode.dart';
import 'package:pedali/features/map/providers/route_color_mode_provider.dart';
import 'package:pedali/l10n/app_localizations.dart';

class RouteColorModeButton extends ConsumerWidget {
  const RouteColorModeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final mode = ref.watch(routeColorModeProvider);

    return AppCircleButton(
      icon: mode == RouteColorMode.speed ? Icons.speed : Icons.route,
      tooltip: t.routeColorTooltip,
      onPressed: () => ref.read(routeColorModeProvider.notifier).toggle(),
    );
  }
}
