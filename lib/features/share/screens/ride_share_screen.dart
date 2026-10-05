import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/features/share/domain/ride_share_service.dart';
import 'package:pedali/features/share/domain/share_card_data.dart';
import 'package:pedali/features/share/widget/ride_share_card.dart';
import 'package:pedali/theme/app_tokens.dart';

class RideShareScreen extends ConsumerStatefulWidget {
  const RideShareScreen({super.key, required this.data});

  final ShareCardData data;

  static Route<void> route(ShareCardData data) =>
      MaterialPageRoute(builder: (_) => RideShareScreen(data: data));

  @override
  ConsumerState<RideShareScreen> createState() => _RideShareScreenState();
}

class _RideShareScreenState extends ConsumerState<RideShareScreen> {
  final _boundaryKey = GlobalKey();
  final _service = const RideShareService();

  var _busy = false;

  Future<void> _share() async {
    if (_busy) return;

    setState(() => _busy = true);

    try {
      final box = context.findRenderObject() as RenderBox?;
      final origin = box == null
          ? null
          : box.localToGlobal(Offset.zero) & box.size;

      final png = await _service.capture(_boundaryKey);
      await _service.share(png, sharePositionOrigin: origin);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не вдалося підготувати картинку')),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const AppHeader(
        title: 'Поділитися поїздкою',
        showBackButton: true,
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Center(
                  child: Material(
                    elevation: 4,
                    shadowColor: cs.shadow,
                    borderRadius: AppRadius.lg,
                    clipBehavior: Clip.antiAlias,
                    child: FittedBox(
                      child: RepaintBoundary(
                        key: _boundaryKey,
                        child: RideShareCard(data: widget.data),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _busy ? null : _share,
                  icon: _busy
                      ? const SizedBox.square(
                          dimension: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.ios_share),
                  label: const Text('Поділитися'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
