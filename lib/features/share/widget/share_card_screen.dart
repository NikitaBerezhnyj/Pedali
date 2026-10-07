import 'package:flutter/material.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'package:pedali/features/share/domain/share_service.dart';
import 'package:pedali/l10n/app_localizations.dart';
import 'package:pedali/theme/app_tokens.dart';

class ShareCardScreen extends StatefulWidget {
  const ShareCardScreen({super.key, required this.title, required this.card});

  final String title;
  final Widget card;

  static Route<void> route({required String title, required Widget card}) =>
      MaterialPageRoute(
        builder: (_) => ShareCardScreen(title: title, card: card),
      );

  @override
  State<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends State<ShareCardScreen> {
  final _boundaryKey = GlobalKey();
  final _service = const ShareService();

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

      final t = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.shareImageError)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppHeader(title: widget.title, showBackButton: true),
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
                        child: widget.card,
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
                  label: Text(t.shareButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
