import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  const RideCard({
    super.key,
    required this.distance,
    required this.subtitle,
    required this.onTap,
  });

  final String distance;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.directions_bike),
        title: Text(distance),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
