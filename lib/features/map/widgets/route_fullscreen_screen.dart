import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:pedali/core/widgets/app_circle_button.dart';
import 'package:pedali/features/map/domain/route_point.dart';
import 'package:pedali/features/map/utils/speed_color_scale.dart';
import 'package:pedali/features/map/widgets/app_tile_layer.dart';
import 'package:pedali/features/map/widgets/route_color_mode_button.dart';
import 'package:pedali/features/map/widgets/route_endpoints_layer.dart';
import 'package:pedali/features/map/widgets/route_map.dart';
import 'package:pedali/features/map/widgets/speed_legend.dart';
import 'package:pedali/l10n/app_localizations.dart';

class RouteFullscreenScreen extends StatefulWidget {
  const RouteFullscreenScreen({super.key, required this.segments});

  final List<List<RoutePoint>> segments;

  static Route<void> route(List<List<RoutePoint>> segments) =>
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => RouteFullscreenScreen(segments: segments),
      );

  @override
  State<RouteFullscreenScreen> createState() => _RouteFullscreenScreenState();
}

class _RouteFullscreenScreenState extends State<RouteFullscreenScreen> {
  final _controller = MapController();

  late final _scale = SpeedColorScale.fromSegments(widget.segments);

  late final CameraFit _fit = CameraFit.bounds(
    bounds: LatLngBounds.fromPoints(
      widget.segments.positions.expand((s) => s).toList(),
    ),
    padding: const EdgeInsets.fromLTRB(32, 96, 32, 64),
    maxZoom: 17,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _controller,
            options: MapOptions(
              initialCameraFit: _fit,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              const AppTileLayer(),
              RouteColorLayer(segments: widget.segments, scale: _scale),
              RouteEndpointsLayer(segments: widget.segments.positions),
              const AppMapAttribution(),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCircleButton(
                    icon: Icons.close,
                    tooltip: t.close,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppCircleButton(
                        icon: Icons.center_focus_strong_outlined,
                        tooltip: t.showFullRoute,
                        onPressed: () => _controller.fitCamera(_fit),
                      ),
                      const SizedBox(height: 8),
                      const RouteColorModeButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: SafeArea(
              child: IgnorePointer(child: SpeedLegend(scale: _scale)),
            ),
          ),
        ],
      ),
    );
  }
}
