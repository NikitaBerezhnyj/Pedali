import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pedali/core/db/app_database.dart';
import 'package:pedali/core/db/ride_repository.dart';
import 'package:pedali/core/location/gps_point.dart';
import 'package:pedali/core/location/location_source.dart';
import 'package:pedali/core/providers/database_provider.dart';
import 'package:pedali/core/providers/location_source_provider.dart';
import 'package:pedali/core/providers/monthly_stats_provider.dart';
import 'package:pedali/core/providers/records_provider.dart';
import 'package:pedali/core/track/location_filter.dart';
import 'package:pedali/core/track/ride_accumulator.dart';
import 'package:pedali/core/track/track_sample.dart';

enum RecorderStatus { idle, recording, paused, saving }

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

  bool get isRecording => status == RecorderStatus.recording;
  bool get isPaused => status == RecorderStatus.paused;
  bool get isActive => isRecording || isPaused;

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
  }) => RecorderState(
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
  );
}

const _minSavableDistanceMeters = 100.0;
const _flushInterval = Duration(seconds: 5);
const _tickInterval = Duration(seconds: 1);

class RecorderController extends Notifier<RecorderState> {
  StreamSubscription<GpsPoint>? _positionSub;
  Timer? _flushTimer;
  Timer? _tickTimer;

  final _accumulator = RideAccumulator();
  final _filter = const LocationFilter();
  final _pendingPoints = <TrackSample>[];

  int? _segmentId;
  DateTime? _segmentStartedAt;
  Duration _elapsedBeforeCurrentSegment = Duration.zero;

  RideRepository get _repo => RideRepository(ref.read(databaseProvider));
  LocationSource get _location => ref.read(locationSourceProvider);

  @override
  RecorderState build() {
    ref.onDispose(_cancelAll);
    return const RecorderState();
  }

  Future<Ride?> checkForActiveRide() => _repo.findActiveRide();

  Future<void> discardStaleRide(Ride ride) => _repo.deleteRide(ride.id);

  Future<void> start() async {
    if (state.status != RecorderStatus.idle) return;

    final granted = await _location.ensurePermissions();
    if (!granted) {
      state = state.copyWith(message: 'Немає дозволу на геолокацію');
      return;
    }

    final now = DateTime.now().toUtc();
    final rideId = await _repo.startRide(now);
    _elapsedBeforeCurrentSegment = Duration.zero;

    state = RecorderState(status: RecorderStatus.recording, rideId: rideId);
    await _openSegmentAndListen(rideId);
    _tickTimer = Timer.periodic(_tickInterval, (_) => _tick());
  }

  Future<void> pause() async {
    if (state.status != RecorderStatus.recording) return;
    await _closeCurrentSegment();
    _tickTimer?.cancel();
    state = state.copyWith(status: RecorderStatus.paused);
  }

  Future<void> resume() async {
    if (state.status != RecorderStatus.paused) return;
    state = state.copyWith(status: RecorderStatus.recording);
    await _openSegmentAndListen(state.rideId!);
    _tickTimer = Timer.periodic(_tickInterval, (_) => _tick());
  }

  Future<void> stop() async {
    if (!state.isActive) return;

    state = state.copyWith(status: RecorderStatus.saving);
    await _closeCurrentSegment();
    _tickTimer?.cancel();

    final rideId = state.rideId!;
    final now = DateTime.now().toUtc();
    final stats = _accumulator.stats;

    await _repo.finishRide(rideId, now, stats);
    await _repo.setElapsedTime(rideId, state.elapsedTime);

    ref.invalidate(recordsProvider);
    ref.invalidate(monthlyStatsProvider);

    state = state.copyWith(status: RecorderStatus.idle);
  }

  bool get isSavable => state.distanceMeters >= _minSavableDistanceMeters;

  Future<void> discardLastRide() async {
    final id = state.rideId;
    if (id != null) await _repo.deleteRide(id);
    _resetLocalState();
  }

  void acknowledgeSaved() => _resetLocalState();

  Future<void> deleteRide(int rideId) => _repo.deleteRide(rideId);

  Future<void> _openSegmentAndListen(int rideId) async {
    final now = DateTime.now().toUtc();
    _segmentId = await _repo.openSegment(rideId, now);
    _segmentStartedAt = now;
    _accumulator.startNewSegment();
    _pendingPoints.clear();

    _positionSub = _location.positions().listen(
      _onPoint,
      onError: (e) {
        state = state.copyWith(message: '$e');
      },
    );
    _flushTimer = Timer.periodic(_flushInterval, (_) => _flush());
  }

  Future<void> _closeCurrentSegment() async {
    await _positionSub?.cancel();
    _positionSub = null;
    _flushTimer?.cancel();
    await _flush();

    final segmentId = _segmentId;
    final startedAt = _segmentStartedAt;
    if (segmentId != null && startedAt != null) {
      final now = DateTime.now().toUtc();
      await _repo.closeSegment(segmentId, now);
      _elapsedBeforeCurrentSegment += now.difference(startedAt);
    }
    _segmentId = null;
    _segmentStartedAt = null;
  }

  void _onPoint(GpsPoint p) {
    final sample = TrackSample(
      time: p.time,
      lat: p.lat,
      lon: p.lon,
      accuracyMeters: p.accuracy,
      speedMps: p.speed,
    );

    state = state.copyWith(currentSpeedMps: p.speed, gpsAccuracy: p.accuracy);

    if (!_filter.accepts(sample)) return;

    _accumulator.addPoint(sample);
    _pendingPoints.add(sample);

    final stats = _accumulator.stats;
    state = state.copyWith(
      distanceMeters: stats.distanceMeters,
      movingTime: stats.movingTime,
      avgSpeedMps: stats.avgSpeedMps,
      maxSpeedMps: stats.maxSpeedMps,
    );
  }

  void _tick() {
    final startedAt = _segmentStartedAt;
    if (startedAt == null) return;
    final now = DateTime.now().toUtc();
    state = state.copyWith(
      elapsedTime: _elapsedBeforeCurrentSegment + now.difference(startedAt),
    );
  }

  Future<void> _flush() async {
    if (_pendingPoints.isEmpty) return;
    final rideId = state.rideId;
    final segmentId = _segmentId;
    if (rideId == null || segmentId == null) return;

    final toSave = List<TrackSample>.from(_pendingPoints);
    _pendingPoints.clear();
    await _repo.insertPoints(rideId, segmentId, toSave);
  }

  void _resetLocalState() {
    _accumulator.startNewSegment();
    _pendingPoints.clear();
    _elapsedBeforeCurrentSegment = Duration.zero;
    state = const RecorderState();
  }

  Future<void> _cancelAll() async {
    await _positionSub?.cancel();
    _flushTimer?.cancel();
    _tickTimer?.cancel();
  }
}

final recorderControllerProvider =
    NotifierProvider<RecorderController, RecorderState>(RecorderController.new);
