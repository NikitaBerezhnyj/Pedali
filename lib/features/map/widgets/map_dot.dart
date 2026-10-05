import 'package:flutter/material.dart';

class MapDot extends StatelessWidget {
  const MapDot({super.key, required this.color, this.size = 18});
  static const borderColor = Colors.white;
  static const double borderWidth = 3;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    final shadow = Theme.of(context).colorScheme.shadow;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: [
          BoxShadow(color: shadow.withValues(alpha: 0.26), blurRadius: 4),
        ],
      ),
    );
  }
}
