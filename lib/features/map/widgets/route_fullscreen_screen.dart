import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:pedali/core/widgets/app_circle_button.dart';
import 'package:pedali/features/map/widgets/app_tile_layer.dart';
import 'package:pedali/features/map/widgets/route_endpoints_layer.dart';
import 'package:pedali/features/map/widgets/route_map.dart';

class RouteFullscreenScreen extends StatefulWidget {
  const RouteFullscreenScreen({super.key, required this.segments});
  final List<List<LatLng>> segments;

  static Route<void> route(List<List<LatLng>> segments) => MaterialPageRoute(
    fullscreenDialog: true,
    builder: (_) => RouteFullscreenScreen(segments: segments),
  );

  @override
  State<RouteFullscreenScreen> createState() => _RouteFullscreenScreenState();
}

class _RouteFullscreenScreenState extends State<RouteFullscreenScreen> {
  final _controller = MapController();
  late final CameraFit _fit = CameraFit.bounds(
    bounds: LatLngBounds.fromPoints(widget.segments.expand((s) => s).toList()),
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
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _controller,
            options: MapOptions(
              initialCameraFit: _fit,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
            ),
            children: [
              const AppTileLayer(),
              RoutePolylineLayer(segments: widget.segments),
              RouteEndpointsLayer(segments: widget.segments),
              const AppMapAttribution(),
            ],
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  AppCircleButton(
                    icon: Icons.close,
                    tooltip: "Закрити",
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  AppCircleButton(
                    icon: Icons.center_focus_strong_outlined,
                    tooltip: "Показати весь маршрут",
                    onPressed: () => _controller.fitCamera(_fit),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
