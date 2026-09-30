// lib/core/map/tile_provider.dart

class TileProviderConfig {
  const TileProviderConfig({
    required this.urlTemplate,
    required this.attribution,
    this.subdomains = const [],
    this.userAgentPackageName = 'com.nikitaberezhnyj.pedali',
  });

  final String urlTemplate;
  final String attribution;
  final List<String> subdomains;
  final String userAgentPackageName;
}

const pedaliTileProvider = TileProviderConfig(
  urlTemplate:
      'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
  attribution: '© OpenStreetMap contributors, CyclOSM',
  subdomains: ['a', 'b', 'c'],
);
