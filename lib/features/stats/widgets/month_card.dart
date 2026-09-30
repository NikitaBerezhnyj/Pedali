import 'package:flutter/material.dart';

class MonthCard extends StatelessWidget {
  const MonthCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.distance,
  });

  final String title;
  final String subtitle;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          distance,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
