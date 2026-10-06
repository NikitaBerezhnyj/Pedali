import 'package:flutter_test/flutter_test.dart';
import 'package:pedali/features/recording/domain/location_filter.dart';
import 'package:pedali/features/rides/domain/gps_track_point.dart';

void main() {
  const filter = LocationFilter();
  final base = DateTime.utc(2026, 9, 26, 10, 0, 0);

  GPSTrackPoint sample({double accuracy = 5, double? speed}) => GPSTrackPoint(
    time: base,
    lat: 50.45,
    lon: 30.52,
    accuracyMeters: accuracy,
    speedMps: speed,
  );

  test('приймає точку з хорошою accuracy і без speed', () {
    expect(filter.accepts(sample()), isTrue);
  });

  test('відхиляє точку з accuracy понад 20 м', () {
    expect(filter.accepts(sample(accuracy: 25)), isFalse);
  });

  test('відхиляє від\'ємну швидкість', () {
    expect(filter.accepts(sample(speed: -1)), isFalse);
  });

  test('відхиляє спайк типу 86 км/год (> 30 м/с)', () {
    expect(filter.accepts(sample(speed: 24)), isTrue); // 86 км/год
    expect(filter.accepts(sample(speed: 40)), isFalse); // 144 км/год
  });
}
