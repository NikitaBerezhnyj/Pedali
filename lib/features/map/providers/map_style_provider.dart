import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/providers/shared_prefs_provider.dart';
import 'package:pedali/features/map/domain/map_style.dart';
import 'package:pedali/features/map/domain/tile_config.dart';

class MapStyleNotifier extends Notifier<MapStyle> {
  static const _key = 'map_style';

  @override
  MapStyle build() {
    final prefs = ref.read(sharedPrefsProvider);
    final saved = prefs.getString(_key);

    return MapStyle.values.firstWhere(
      (style) => style.name == saved,
      orElse: () => MapStyle.cycling,
    );
  }

  Future<void> setStyle(MapStyle style) async {
    final prefs = ref.read(sharedPrefsProvider);
    await prefs.setString(_key, style.name);
    state = style;
  }
}

final mapStyleProvider = NotifierProvider<MapStyleNotifier, MapStyle>(
  MapStyleNotifier.new,
);

final activeMapStyleProvider = Provider<TileProviderConfig>((ref) {
  final style = ref.watch(mapStyleProvider);
  return mapStyleTiles[style]!;
});
