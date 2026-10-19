import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/providers/shared_prefs_provider.dart';
import 'package:pedali/features/map/domain/route_color_mode.dart';

class RouteColorModeNotifier extends Notifier<RouteColorMode> {
  static const _key = 'route_color_mode';

  @override
  RouteColorMode build() {
    final prefs = ref.read(sharedPrefsProvider);
    final saved = prefs.getString(_key);

    return RouteColorMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => RouteColorMode.speed,
    );
  }

  Future<void> toggle() async {
    final next = state == RouteColorMode.speed
        ? RouteColorMode.brand
        : RouteColorMode.speed;

    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setString(_key, next.name);
    state = next;
  }
}

final routeColorModeProvider =
    NotifierProvider<RouteColorModeNotifier, RouteColorMode>(
      RouteColorModeNotifier.new,
    );
