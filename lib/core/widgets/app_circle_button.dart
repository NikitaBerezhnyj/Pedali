import 'package:flutter/material.dart';

enum AppCircleButtonVariant { surface, tonal, filled, destructive }

class AppCircleButton extends StatelessWidget {
  const AppCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.variant = AppCircleButtonVariant.surface,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final AppCircleButtonVariant variant;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final (bg, fg, elevation) = switch (variant) {
      AppCircleButtonVariant.surface => (cs.surface, cs.onSurface, 3.0),
      AppCircleButtonVariant.tonal => (
        cs.primaryContainer,
        cs.onPrimaryContainer,
        0.0,
      ),
      AppCircleButtonVariant.filled => (cs.primary, cs.onPrimary, 0.0),
      AppCircleButtonVariant.destructive => (cs.error, cs.onError, 0.0),
    };

    return IconButton.filled(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        elevation: elevation,
        shadowColor: cs.shadow,
      ),
    );
  }
}
