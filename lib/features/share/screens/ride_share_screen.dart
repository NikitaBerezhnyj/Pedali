import 'package:flutter/material.dart';
import 'package:pedali/features/share/domain/share_card_data.dart';
import 'package:pedali/features/share/widget/ride_share_card.dart';
import 'package:pedali/features/share/widget/share_card_screen.dart';
import 'package:pedali/l10n/app_localizations.dart';

class RideShareScreen extends StatelessWidget {
  const RideShareScreen({super.key, required this.data});

  final RideShareCardData data;

  static Route<void> route(RideShareCardData data) =>
      MaterialPageRoute(builder: (_) => RideShareScreen(data: data));

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return ShareCardScreen(
      title: t.shareRideTitle,
      card: RideShareCard(data: data),
    );
  }
}
