import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.iconColor,
    this.iconBackgroundColor,
    this.iconSize = 44,
    this.showIconBackground = true,
  });

  final IconData icon;
  final String title;
  final String description;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final double iconSize;
  final bool showIconBackground;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final resolvedIconColor = iconColor ?? theme.colorScheme.onPrimaryContainer;

    final resolvedBackgroundColor =
        iconBackgroundColor ?? theme.colorScheme.primaryContainer;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIconBackground)
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: resolvedBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: iconSize, color: resolvedIconColor),
            )
          else
            Icon(icon, size: iconSize, color: resolvedIconColor),
          const SizedBox(height: 24),
          Text(
            title,
            style: theme.textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
