import 'package:pedali/features/map/domain/map_style.dart';

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

const _cycling = TileProviderConfig(
  urlTemplate:
      'https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png',
  attribution: '© OpenStreetMap contributors, CyclOSM',
  subdomains: ['a', 'b', 'c'],
);

const _terrain = TileProviderConfig(
  urlTemplate: 'https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png',
  attribution: '© OpenStreetMap contributors, SRTM, OpenTopoMap',
  subdomains: ['a', 'b', 'c'],
);

const _satellite = TileProviderConfig(
  urlTemplate:
      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
  attribution: 'Esri, Maxar, Earthstar Geographics',
);

const Map<MapStyle, TileProviderConfig> mapStyleTiles = {
  MapStyle.cycling: _cycling,
  MapStyle.terrain: _terrain,
  MapStyle.satellite: _satellite,
};
