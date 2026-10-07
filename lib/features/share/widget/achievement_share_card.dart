import 'package:flutter/material.dart';
import 'package:pedali/app/app_theme.dart';

class AchievementShareCard extends StatelessWidget {
  const AchievementShareCard({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
    required this.completedLabel,
  });

  static const double size = 360;

  final IconData icon;
  final String label;
  final String description;
  final String completedLabel;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final bg = AppTheme.seed.shade800;
    final soft = AppTheme.seed.shade100;

    return MediaQuery.withNoTextScaling(
      child: SizedBox(
        width: size,
        height: size,
        child: ColoredBox(
          color: bg,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.directions_bike, size: 17, color: bg),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Pedali',
                      style: tt.labelLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, size: 60, color: bg),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        completedLabel.toUpperCase(),
                        style: tt.labelSmall?.copyWith(
                          color: soft,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: tt.displaySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        textAlign: TextAlign.center,
                        style: tt.bodyMedium?.copyWith(color: soft),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
