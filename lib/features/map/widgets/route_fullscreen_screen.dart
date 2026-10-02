import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
                  _MapButton(
                    icon: Icons.close,
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  _MapButton(
                    icon: Icons.center_focus_strong_outlined,
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

class _MapButton extends StatelessWidget {
  const _MapButton({required this.icon, required this.onPressed});
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      elevation: 2,
      child: IconButton(
        icon: Icon(icon),
        color: cs.onSurface,
        onPressed: onPressed,
      ),
    );
  }
}
