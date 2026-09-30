import 'package:latlong2/latlong.dart';

enum RecorderStatus { idle, recording, paused, autoPaused, saving }

class RecorderState {
  const RecorderState({
    this.status = RecorderStatus.idle,
    this.rideId,
    this.distanceMeters = 0,
    this.movingTime = Duration.zero,
    this.elapsedTime = Duration.zero,
    this.avgSpeedMps = 0,
    this.maxSpeedMps = 0,
    this.currentSpeedMps,
    this.gpsAccuracy,
    this.message,
    this.trackPoints = const [],
    this.currentPosition,
  });

  final RecorderStatus status;
  final int? rideId;
  final double distanceMeters;
  final Duration movingTime;
  final Duration elapsedTime;
  final double avgSpeedMps;
  final double maxSpeedMps;
  final double? currentSpeedMps;
  final double? gpsAccuracy;
  final String? message;
  final List<LatLng> trackPoints;
  final LatLng? currentPosition;

  bool get isRecording => status == RecorderStatus.recording;

  bool get isManuallyPaused => status == RecorderStatus.paused;

  bool get isAutoPaused => status == RecorderStatus.autoPaused;

  bool get isActive => isRecording || isManuallyPaused || isAutoPaused;

  RecorderState copyWith({
    RecorderStatus? status,
    int? rideId,
    double? distanceMeters,
    Duration? movingTime,
    Duration? elapsedTime,
    double? avgSpeedMps,
    double? maxSpeedMps,
    double? currentSpeedMps,
    double? gpsAccuracy,
    String? message,
    List<LatLng>? trackPoints,
    LatLng? currentPosition,
  }) {
    return RecorderState(
      status: status ?? this.status,
      rideId: rideId ?? this.rideId,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      movingTime: movingTime ?? this.movingTime,
      elapsedTime: elapsedTime ?? this.elapsedTime,
      avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
      maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
      currentSpeedMps: currentSpeedMps ?? this.currentSpeedMps,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
      message: message,
      trackPoints: trackPoints ?? this.trackPoints,
      currentPosition: currentPosition ?? this.currentPosition,
    );
  }
}
