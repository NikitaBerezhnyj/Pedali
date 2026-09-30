import 'package:flutter/material.dart';
import 'package:pedali/core/providers/map_style_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/format.dart';
import 'package:pedali/core/providers/units_provider.dart';
import 'package:pedali/core/providers/keep_screen_on_provider.dart';
import 'package:pedali/core/units.dart';
import 'recorder_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RecordingScreen extends ConsumerStatefulWidget {
  const RecordingScreen({super.key});

  @override
  ConsumerState<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  final _mapController = MapController();
  final _sheetController = DraggableScrollableController();
  bool _followMe = true;

  static const _sheetMin = 0.10;
  static const _sheetInitial = 0.30;
  static const _sheetMax = 0.30;

  @override
  void initState() {
    super.initState();
    if (ref.read(keepScreenOnProvider)) {
      WakelockPlus.enable();
    }
  }

  @override
  void dispose() {
    _sheetController.dispose();
    WakelockPlus.disable();
    super.dispose();
  }

  void _recenter(LatLng? position) {
    if (position == null) return;
    setState(() => _followMe = true);
    _mapController.move(position, _mapController.camera.zoom);
  }

  Future<void> _confirmStop(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Завершити поїздку?'),
        content: const Text('Запис зупиниться і поїздку буде збережено.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Скасувати'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Завершити'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final controller = ref.read(recorderControllerProvider.notifier);

    await controller.stop();
    if (!context.mounted) return;

    if (!controller.isSavable) {
      final keep = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Дуже коротка поїздка'),
          content: const Text('Зберегти її все одно?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Видалити'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Зберегти'),
            ),
          ],
        ),
      );

      if (keep == false) {
        await controller.discardLastRide();
      } else {
        controller.acknowledgeSaved();
      }
    } else {
      controller.acknowledgeSaved();
    }

    if (context.mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final s = ref.watch(recorderControllerProvider);
    final c = ref.read(recorderControllerProvider.notifier);
    final units = ref.watch(unitsProvider);
    final tileConfig = ref.watch(activeMapStyleProvider);

    ref.listen(recorderControllerProvider, (previous, next) {
      if (_followMe && next.currentPosition != null) {
        _mapController.move(next.currentPosition!, _mapController.camera.zoom);
      }
    });

    final screenHeight = MediaQuery.of(context).size.height;
    const gapAboveSheet = 16.0;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: s.currentPosition ?? const LatLng(50.45, 30.52),
              initialZoom: 16,
              onPositionChanged: (position, hasGesture) {
                if (hasGesture && _followMe) {
                  setState(() => _followMe = false);
                }
              },
            ),
            children: [
              TileLayer(
                urlTemplate: tileConfig.urlTemplate,
                subdomains: tileConfig.subdomains,
                userAgentPackageName: tileConfig.userAgentPackageName,
              ),
              if (s.trackPoints.length > 1)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: s.trackPoints,
                      strokeWidth: 4,
                      color: cs.primary,
                    ),
                  ],
                ),
              if (s.currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: s.currentPosition!,
                      width: 22,
                      height: 22,
                      child: Container(
                        decoration: BoxDecoration(
                          color: cs.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(color: Colors.black26, blurRadius: 4),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              RichAttributionWidget(
                attributions: [TextSourceAttribution(tileConfig.attribution)],
              ),
            ],
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 12,
            child: _RoundIconButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.pop(context),
            ),
          ),

          if (!_followMe)
            AnimatedBuilder(
              animation: _sheetController,
              builder: (context, child) {
                final sheetExtent = _sheetController.isAttached
                    ? _sheetController.size
                    : _sheetInitial;
                return Positioned(
                  right: 12,
                  bottom: screenHeight * sheetExtent + gapAboveSheet,
                  child: child!,
                );
              },

              child: _RoundIconButton(
                icon: Icons.my_location,
                onPressed: () => _recenter(s.currentPosition),
              ),
            ),

          DraggableScrollableSheet(
            controller: _sheetController,
            initialChildSize: _sheetInitial,
            minChildSize: _sheetMin,
            maxChildSize: _sheetMax,
            snap: true,
            snapSizes: const [_sheetMin, _sheetInitial],
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 12),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.fromLTRB(
                    20,
                    8,
                    20,
                    MediaQuery.of(context).padding.bottom + 16,
                  ),
                  children: [
                    Center(
                      child: Container(
                        width: 36,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: cs.outlineVariant,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          s.currentSpeedMps == null
                              ? '--'
                              : units
                                    .formatSpeed(s.currentSpeedMps!)
                                    .split(' ')
                                    .first,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          units == UnitSystem.imperial ? 'mph' : 'km/h',
                          style: theme.textTheme.bodySmall,
                        ),
                        const Spacer(),
                        if (s.status == RecorderStatus.recording) ...[
                          _CircleActionButton(
                            icon: Icons.pause,
                            onPressed: c.pause,
                          ),
                          const SizedBox(width: 8),
                          _CircleActionButton(
                            icon: Icons.stop,
                            color: cs.error,
                            onPressed: () => _confirmStop(context, ref),
                          ),
                        ] else if (s.status == RecorderStatus.paused) ...[
                          _CircleActionButton(
                            icon: Icons.play_arrow,
                            onPressed: c.resume,
                          ),
                          const SizedBox(width: 8),
                          _CircleActionButton(
                            icon: Icons.stop,
                            color: cs.error,
                            onPressed: () => _confirmStop(context, ref),
                          ),
                        ] else if (s.status == RecorderStatus.autoPaused)
                          _CircleActionButton(
                            icon: Icons.stop,
                            color: cs.error,
                            onPressed: () => _confirmStop(context, ref),
                          ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          units.formatDistance(s.distanceMeters),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text('дистанція', style: theme.textTheme.bodySmall),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _MiniStat('Час у русі', formatDuration(s.movingTime)),
                        _MiniStat('Заг. час', formatDuration(s.elapsedTime)),
                        _MiniStat(
                          'Сер. швидк.',
                          units.formatSpeed(s.avgSpeedMps),
                        ),
                        _MiniStat('Макс.', units.formatSpeed(s.maxSpeedMps)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (s.status == RecorderStatus.autoPaused)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: cs.errorContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.gps_off,
                              color: cs.onErrorContainer,
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'GPS нестабільний — запис призупинено',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: cs.onErrorContainer,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Text(
                        s.gpsAccuracy == null
                            ? 'GPS: пошук сигналу'
                            : 'GPS: ±${s.gpsAccuracy!.toStringAsFixed(0)} м',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: (s.gpsAccuracy ?? 999) <= 20
                              ? Colors.green
                              : Colors.orange,
                        ),
                      ),
                    if (s.message != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        s.message!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 3,
      child: IconButton(icon: Icon(icon), onPressed: onPressed),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({
    required this.icon,
    required this.onPressed,
    this.color,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: color ?? cs.primaryContainer,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(
            icon,
            color: color != null ? Colors.white : cs.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
