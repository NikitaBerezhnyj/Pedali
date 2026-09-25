import 'package:flutter_test/flutter_test.dart';
import 'package:pedali/core/track/ride_accumulator.dart';
import 'package:pedali/core/track/track_sample.dart';

void main() {
  final t0 = DateTime.utc(2026, 9, 26, 10, 0, 0);
  DateTime at(int seconds) => t0.add(Duration(seconds: seconds));

  TrackSample p(int seconds, double lat, double lon, {double? speedMps}) =>
      TrackSample(
        time: at(seconds),
        lat: lat,
        lon: lon,
        accuracyMeters: 5,
        speedMps: speedMps,
      );

  test('стоянка з GPS-дрейфом не накручує дистанцію і час', () {
    final acc = RideAccumulator()..startNewSegment();
    // Точки хаотично тремтять у радіусі ~1-2 м навколо однієї позиції.
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(5, 50.45001, 30.52000));
    acc.addPoint(p(10, 50.44999, 30.52001));
    acc.addPoint(p(15, 50.45000, 30.51999));

    expect(acc.stats.distanceMeters, closeTo(0, 1));
    expect(acc.stats.movingTime, Duration.zero);
  });

  test('реальний рух за 10 с додає дистанцію і moving time', () {
    final acc = RideAccumulator()..startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    // ~55 м за 10 с ~= 5.5 м/с ~= 20 км/год, вище порогу руху
    acc.addPoint(p(10, 50.45050, 30.52000));

    expect(acc.stats.distanceMeters, greaterThan(40));
    expect(acc.stats.movingTime, Duration(seconds: 10));
  });

  test('пауза між сегментами не рахується як переміщення', () {
    final acc = RideAccumulator();

    acc.startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000)); // ~55 м руху

    final distanceBeforePause = acc.stats.distanceMeters;

    // Пауза 5 хв, потім поїздка продовжилась в геть іншому місці.
    acc.startNewSegment();
    acc.addPoint(p(300, 51.00000, 31.00000));
    acc.addPoint(p(310, 51.00050, 31.00000));

    // Дистанція зросла лише на реальний крок нового сегмента,
    // а не на телепорт між 50.45/30.52 і 51.00/31.00.
    final totalDistance = acc.stats.distanceMeters;
    expect(totalDistance - distanceBeforePause, lessThan(100));
  });

  test('одиночний GPS-спайк 86 км/год не ламає max speed', () {
    final acc = RideAccumulator();
    acc.startNewSegment();

    // Реальна поїздка ~35-38 км/год (9.7-10.6 м/с), з одним биттям
    // значенням швидкості (не позиції) на 86 км/год (23.9 м/с).
    final speedsKmh = [37.0, 42.0, 86.0, 39.0, 38.0, 37.0, 38.0];
    var lat = 50.45000;
    for (var i = 0; i < speedsKmh.length; i++) {
      lat += 0.0001; // ~11 м кожні 2 с — узгоджено з реальною швидкістю
      acc.addPoint(p(i * 2, lat, 30.52000, speedMps: speedsKmh[i] / 3.6));
    }

    // Медіана вікна не пропускає одиничний 86 км/год нагору.
    expect(acc.stats.maxSpeedMps * 3.6, lessThan(45));
  });

  test('точки без speed (як з GPX) рахуються через implied speed', () {
    final acc = RideAccumulator()..startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000));

    expect(acc.stats.maxSpeedMps, greaterThan(0));
  });

  test('avg speed = distance / moving time, а не / elapsed', () {
    final acc = RideAccumulator();
    acc.startNewSegment();
    acc.addPoint(p(0, 50.45000, 30.52000));
    acc.addPoint(p(10, 50.45050, 30.52000)); // рух 10 с

    acc.startNewSegment(); // пауза, що не входить у moving time
    acc.addPoint(p(300, 50.45050, 30.52000));
    acc.addPoint(p(310, 50.45100, 30.52000)); // ще 10 с руху

    final stats = acc.stats;
    // Загальний elapsed від першої до останньої точки ~310 с,
    // але moving time має бути лише 20 с (два рухи по 10 с).
    expect(stats.movingTime, Duration(seconds: 20));
    expect(stats.avgSpeedMps, closeTo(stats.distanceMeters / 20, 0.01));
  });
}
