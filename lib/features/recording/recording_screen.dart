import 'package:flutter/material.dart';
import 'package:pedali/core/map/tile_provider.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/format.dart';
import 'package:pedali/core/providers/units_provider.dart';
import 'package:pedali/core/providers/keep_screen_on_provider.dart';
import 'package:pedali/core/units.dart';
import 'package:pedali/core/widgets/app_button.dart';
import 'package:pedali/core/widgets/app_header.dart';
import 'recorder_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RecordingScreen extends ConsumerStatefulWidget {
  const RecordingScreen({super.key});

  @override
  ConsumerState<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  @override
  void initState() {
    super.initState();
    if (ref.read(keepScreenOnProvider)) {
      WakelockPlus.enable();
    }
  }

  @override
  void dispose() {
    WakelockPlus.disable();
    super.dispose();
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

    final currentSpeed = s.currentSpeedMps;

    return Scaffold(
      appBar: const AppHeader(title: 'Поїздка'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter:
                          s.currentPosition ?? const LatLng(50.45, 30.52),
                      initialZoom: 15,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: pedaliTileProvider.urlTemplate,
                        subdomains: pedaliTileProvider.subdomains,
                        userAgentPackageName:
                            pedaliTileProvider.userAgentPackageName,
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
                              width: 20,
                              height: 20,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: cs.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      RichAttributionWidget(
                        attributions: [
                          TextSourceAttribution(pedaliTileProvider.attribution),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                currentSpeed == null
                    ? '--'
                    : units.formatSpeed(currentSpeed).split(' ').first,
                style: theme.textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 72,
                ),
              ),
              Text(
                currentSpeed == null
                    ? 'Пошук сигналу'
                    : units == UnitSystem.imperial
                    ? 'mph'
                    : 'km/h',
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Text(
                units.formatDistance(s.distanceMeters),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text('Дистанція', style: theme.textTheme.bodySmall),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Stat(
                    label: 'Час у русі',
                    value: formatDuration(s.movingTime),
                  ),
                  _Stat(
                    label: 'Заг. час',
                    value: formatDuration(s.elapsedTime),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Stat(
                    label: 'Сер. швидкість',
                    value: units.formatSpeed(s.avgSpeedMps),
                  ),
                  _Stat(
                    label: 'Макс. швидкість',
                    value: units.formatSpeed(s.maxSpeedMps),
                  ),
                ],
              ),
              const SizedBox(height: 12),
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
                Text(s.message!, style: const TextStyle(color: Colors.red)),
              ],
              const Spacer(),
              if (s.status == RecorderStatus.autoPaused) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.errorContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.gps_off, color: cs.onErrorContainer),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'GPS нестабільний — запис призупинено автоматично',
                          style: TextStyle(color: cs.onErrorContainer),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    label: 'Стоп',
                    color: cs.error,
                    onPressed: () => _confirmStop(context, ref),
                  ),
                ),
              ] else if (s.status == RecorderStatus.recording) ...[
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(label: 'Пауза', onPressed: c.pause),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: 'Стоп',
                    color: cs.error,
                    onPressed: () => _confirmStop(context, ref),
                  ),
                ),
              ] else if (s.status == RecorderStatus.paused) ...[
                SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                    label: 'Продовжити',
                    onPressed: c.resume,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlineButton(
                    label: 'Стоп',
                    color: cs.error,
                    onPressed: () => _confirmStop(context, ref),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}
