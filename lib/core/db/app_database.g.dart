// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RidesTable extends Rides with TableInfo<$RidesTable, Ride> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RidesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<int> endedAt = GeneratedColumn<int>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RideStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RideStatus>($RidesTable.$converterstatus);
  static const VerificationMeta _distanceMetersMeta = const VerificationMeta(
    'distanceMeters',
  );
  @override
  late final GeneratedColumn<double> distanceMeters = GeneratedColumn<double>(
    'distance_meters',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _movingTimeMsMeta = const VerificationMeta(
    'movingTimeMs',
  );
  @override
  late final GeneratedColumn<int> movingTimeMs = GeneratedColumn<int>(
    'moving_time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _elapsedTimeMsMeta = const VerificationMeta(
    'elapsedTimeMs',
  );
  @override
  late final GeneratedColumn<int> elapsedTimeMs = GeneratedColumn<int>(
    'elapsed_time_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _maxSpeedMpsMeta = const VerificationMeta(
    'maxSpeedMps',
  );
  @override
  late final GeneratedColumn<double> maxSpeedMps = GeneratedColumn<double>(
    'max_speed_mps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _avgSpeedMpsMeta = const VerificationMeta(
    'avgSpeedMps',
  );
  @override
  late final GeneratedColumn<double> avgSpeedMps = GeneratedColumn<double>(
    'avg_speed_mps',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    startedAt,
    endedAt,
    status,
    distanceMeters,
    movingTimeMs,
    elapsedTimeMs,
    maxSpeedMps,
    avgSpeedMps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'rides';
  @override
  VerificationContext validateIntegrity(
    Insertable<Ride> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    if (data.containsKey('distance_meters')) {
      context.handle(
        _distanceMetersMeta,
        distanceMeters.isAcceptableOrUnknown(
          data['distance_meters']!,
          _distanceMetersMeta,
        ),
      );
    }
    if (data.containsKey('moving_time_ms')) {
      context.handle(
        _movingTimeMsMeta,
        movingTimeMs.isAcceptableOrUnknown(
          data['moving_time_ms']!,
          _movingTimeMsMeta,
        ),
      );
    }
    if (data.containsKey('elapsed_time_ms')) {
      context.handle(
        _elapsedTimeMsMeta,
        elapsedTimeMs.isAcceptableOrUnknown(
          data['elapsed_time_ms']!,
          _elapsedTimeMsMeta,
        ),
      );
    }
    if (data.containsKey('max_speed_mps')) {
      context.handle(
        _maxSpeedMpsMeta,
        maxSpeedMps.isAcceptableOrUnknown(
          data['max_speed_mps']!,
          _maxSpeedMpsMeta,
        ),
      );
    }
    if (data.containsKey('avg_speed_mps')) {
      context.handle(
        _avgSpeedMpsMeta,
        avgSpeedMps.isAcceptableOrUnknown(
          data['avg_speed_mps']!,
          _avgSpeedMpsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Ride map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Ride(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ended_at'],
      ),
      status: $RidesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      distanceMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_meters'],
      )!,
      movingTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}moving_time_ms'],
      )!,
      elapsedTimeMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}elapsed_time_ms'],
      )!,
      maxSpeedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_speed_mps'],
      )!,
      avgSpeedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}avg_speed_mps'],
      )!,
    );
  }

  @override
  $RidesTable createAlias(String alias) {
    return $RidesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RideStatus, String, String> $converterstatus =
      const EnumNameConverter<RideStatus>(RideStatus.values);
}

class Ride extends DataClass implements Insertable<Ride> {
  final int id;
  final int startedAt;
  final int? endedAt;
  final RideStatus status;
  final double distanceMeters;
  final int movingTimeMs;
  final int elapsedTimeMs;
  final double maxSpeedMps;
  final double avgSpeedMps;
  const Ride({
    required this.id,
    required this.startedAt,
    this.endedAt,
    required this.status,
    required this.distanceMeters,
    required this.movingTimeMs,
    required this.elapsedTimeMs,
    required this.maxSpeedMps,
    required this.avgSpeedMps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<int>(endedAt);
    }
    {
      map['status'] = Variable<String>(
        $RidesTable.$converterstatus.toSql(status),
      );
    }
    map['distance_meters'] = Variable<double>(distanceMeters);
    map['moving_time_ms'] = Variable<int>(movingTimeMs);
    map['elapsed_time_ms'] = Variable<int>(elapsedTimeMs);
    map['max_speed_mps'] = Variable<double>(maxSpeedMps);
    map['avg_speed_mps'] = Variable<double>(avgSpeedMps);
    return map;
  }

  RidesCompanion toCompanion(bool nullToAbsent) {
    return RidesCompanion(
      id: Value(id),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
      status: Value(status),
      distanceMeters: Value(distanceMeters),
      movingTimeMs: Value(movingTimeMs),
      elapsedTimeMs: Value(elapsedTimeMs),
      maxSpeedMps: Value(maxSpeedMps),
      avgSpeedMps: Value(avgSpeedMps),
    );
  }

  factory Ride.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Ride(
      id: serializer.fromJson<int>(json['id']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      endedAt: serializer.fromJson<int?>(json['endedAt']),
      status: $RidesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      distanceMeters: serializer.fromJson<double>(json['distanceMeters']),
      movingTimeMs: serializer.fromJson<int>(json['movingTimeMs']),
      elapsedTimeMs: serializer.fromJson<int>(json['elapsedTimeMs']),
      maxSpeedMps: serializer.fromJson<double>(json['maxSpeedMps']),
      avgSpeedMps: serializer.fromJson<double>(json['avgSpeedMps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'startedAt': serializer.toJson<int>(startedAt),
      'endedAt': serializer.toJson<int?>(endedAt),
      'status': serializer.toJson<String>(
        $RidesTable.$converterstatus.toJson(status),
      ),
      'distanceMeters': serializer.toJson<double>(distanceMeters),
      'movingTimeMs': serializer.toJson<int>(movingTimeMs),
      'elapsedTimeMs': serializer.toJson<int>(elapsedTimeMs),
      'maxSpeedMps': serializer.toJson<double>(maxSpeedMps),
      'avgSpeedMps': serializer.toJson<double>(avgSpeedMps),
    };
  }

  Ride copyWith({
    int? id,
    int? startedAt,
    Value<int?> endedAt = const Value.absent(),
    RideStatus? status,
    double? distanceMeters,
    int? movingTimeMs,
    int? elapsedTimeMs,
    double? maxSpeedMps,
    double? avgSpeedMps,
  }) => Ride(
    id: id ?? this.id,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
    status: status ?? this.status,
    distanceMeters: distanceMeters ?? this.distanceMeters,
    movingTimeMs: movingTimeMs ?? this.movingTimeMs,
    elapsedTimeMs: elapsedTimeMs ?? this.elapsedTimeMs,
    maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
    avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
  );
  Ride copyWithCompanion(RidesCompanion data) {
    return Ride(
      id: data.id.present ? data.id.value : this.id,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      status: data.status.present ? data.status.value : this.status,
      distanceMeters: data.distanceMeters.present
          ? data.distanceMeters.value
          : this.distanceMeters,
      movingTimeMs: data.movingTimeMs.present
          ? data.movingTimeMs.value
          : this.movingTimeMs,
      elapsedTimeMs: data.elapsedTimeMs.present
          ? data.elapsedTimeMs.value
          : this.elapsedTimeMs,
      maxSpeedMps: data.maxSpeedMps.present
          ? data.maxSpeedMps.value
          : this.maxSpeedMps,
      avgSpeedMps: data.avgSpeedMps.present
          ? data.avgSpeedMps.value
          : this.avgSpeedMps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Ride(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('movingTimeMs: $movingTimeMs, ')
          ..write('elapsedTimeMs: $elapsedTimeMs, ')
          ..write('maxSpeedMps: $maxSpeedMps, ')
          ..write('avgSpeedMps: $avgSpeedMps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    startedAt,
    endedAt,
    status,
    distanceMeters,
    movingTimeMs,
    elapsedTimeMs,
    maxSpeedMps,
    avgSpeedMps,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Ride &&
          other.id == this.id &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.status == this.status &&
          other.distanceMeters == this.distanceMeters &&
          other.movingTimeMs == this.movingTimeMs &&
          other.elapsedTimeMs == this.elapsedTimeMs &&
          other.maxSpeedMps == this.maxSpeedMps &&
          other.avgSpeedMps == this.avgSpeedMps);
}

class RidesCompanion extends UpdateCompanion<Ride> {
  final Value<int> id;
  final Value<int> startedAt;
  final Value<int?> endedAt;
  final Value<RideStatus> status;
  final Value<double> distanceMeters;
  final Value<int> movingTimeMs;
  final Value<int> elapsedTimeMs;
  final Value<double> maxSpeedMps;
  final Value<double> avgSpeedMps;
  const RidesCompanion({
    this.id = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.status = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.movingTimeMs = const Value.absent(),
    this.elapsedTimeMs = const Value.absent(),
    this.maxSpeedMps = const Value.absent(),
    this.avgSpeedMps = const Value.absent(),
  });
  RidesCompanion.insert({
    this.id = const Value.absent(),
    required int startedAt,
    this.endedAt = const Value.absent(),
    required RideStatus status,
    this.distanceMeters = const Value.absent(),
    this.movingTimeMs = const Value.absent(),
    this.elapsedTimeMs = const Value.absent(),
    this.maxSpeedMps = const Value.absent(),
    this.avgSpeedMps = const Value.absent(),
  }) : startedAt = Value(startedAt),
       status = Value(status);
  static Insertable<Ride> custom({
    Expression<int>? id,
    Expression<int>? startedAt,
    Expression<int>? endedAt,
    Expression<String>? status,
    Expression<double>? distanceMeters,
    Expression<int>? movingTimeMs,
    Expression<int>? elapsedTimeMs,
    Expression<double>? maxSpeedMps,
    Expression<double>? avgSpeedMps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (status != null) 'status': status,
      if (distanceMeters != null) 'distance_meters': distanceMeters,
      if (movingTimeMs != null) 'moving_time_ms': movingTimeMs,
      if (elapsedTimeMs != null) 'elapsed_time_ms': elapsedTimeMs,
      if (maxSpeedMps != null) 'max_speed_mps': maxSpeedMps,
      if (avgSpeedMps != null) 'avg_speed_mps': avgSpeedMps,
    });
  }

  RidesCompanion copyWith({
    Value<int>? id,
    Value<int>? startedAt,
    Value<int?>? endedAt,
    Value<RideStatus>? status,
    Value<double>? distanceMeters,
    Value<int>? movingTimeMs,
    Value<int>? elapsedTimeMs,
    Value<double>? maxSpeedMps,
    Value<double>? avgSpeedMps,
  }) {
    return RidesCompanion(
      id: id ?? this.id,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      status: status ?? this.status,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      movingTimeMs: movingTimeMs ?? this.movingTimeMs,
      elapsedTimeMs: elapsedTimeMs ?? this.elapsedTimeMs,
      maxSpeedMps: maxSpeedMps ?? this.maxSpeedMps,
      avgSpeedMps: avgSpeedMps ?? this.avgSpeedMps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<int>(endedAt.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $RidesTable.$converterstatus.toSql(status.value),
      );
    }
    if (distanceMeters.present) {
      map['distance_meters'] = Variable<double>(distanceMeters.value);
    }
    if (movingTimeMs.present) {
      map['moving_time_ms'] = Variable<int>(movingTimeMs.value);
    }
    if (elapsedTimeMs.present) {
      map['elapsed_time_ms'] = Variable<int>(elapsedTimeMs.value);
    }
    if (maxSpeedMps.present) {
      map['max_speed_mps'] = Variable<double>(maxSpeedMps.value);
    }
    if (avgSpeedMps.present) {
      map['avg_speed_mps'] = Variable<double>(avgSpeedMps.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RidesCompanion(')
          ..write('id: $id, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('status: $status, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('movingTimeMs: $movingTimeMs, ')
          ..write('elapsedTimeMs: $elapsedTimeMs, ')
          ..write('maxSpeedMps: $maxSpeedMps, ')
          ..write('avgSpeedMps: $avgSpeedMps')
          ..write(')'))
        .toString();
  }
}

class $RideSegmentsTable extends RideSegments
    with TableInfo<$RideSegmentsTable, RideSegment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RideSegmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rideIdMeta = const VerificationMeta('rideId');
  @override
  late final GeneratedColumn<int> rideId = GeneratedColumn<int>(
    'ride_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rides (id)',
    ),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endedAtMeta = const VerificationMeta(
    'endedAt',
  );
  @override
  late final GeneratedColumn<int> endedAt = GeneratedColumn<int>(
    'ended_at',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, rideId, startedAt, endedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ride_segments';
  @override
  VerificationContext validateIntegrity(
    Insertable<RideSegment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ride_id')) {
      context.handle(
        _rideIdMeta,
        rideId.isAcceptableOrUnknown(data['ride_id']!, _rideIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rideIdMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(
        _endedAtMeta,
        endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RideSegment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RideSegment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rideId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ride_id'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}started_at'],
      )!,
      endedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ended_at'],
      ),
    );
  }

  @override
  $RideSegmentsTable createAlias(String alias) {
    return $RideSegmentsTable(attachedDatabase, alias);
  }
}

class RideSegment extends DataClass implements Insertable<RideSegment> {
  final int id;
  final int rideId;
  final int startedAt;
  final int? endedAt;
  const RideSegment({
    required this.id,
    required this.rideId,
    required this.startedAt,
    this.endedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ride_id'] = Variable<int>(rideId);
    map['started_at'] = Variable<int>(startedAt);
    if (!nullToAbsent || endedAt != null) {
      map['ended_at'] = Variable<int>(endedAt);
    }
    return map;
  }

  RideSegmentsCompanion toCompanion(bool nullToAbsent) {
    return RideSegmentsCompanion(
      id: Value(id),
      rideId: Value(rideId),
      startedAt: Value(startedAt),
      endedAt: endedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(endedAt),
    );
  }

  factory RideSegment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RideSegment(
      id: serializer.fromJson<int>(json['id']),
      rideId: serializer.fromJson<int>(json['rideId']),
      startedAt: serializer.fromJson<int>(json['startedAt']),
      endedAt: serializer.fromJson<int?>(json['endedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rideId': serializer.toJson<int>(rideId),
      'startedAt': serializer.toJson<int>(startedAt),
      'endedAt': serializer.toJson<int?>(endedAt),
    };
  }

  RideSegment copyWith({
    int? id,
    int? rideId,
    int? startedAt,
    Value<int?> endedAt = const Value.absent(),
  }) => RideSegment(
    id: id ?? this.id,
    rideId: rideId ?? this.rideId,
    startedAt: startedAt ?? this.startedAt,
    endedAt: endedAt.present ? endedAt.value : this.endedAt,
  );
  RideSegment copyWithCompanion(RideSegmentsCompanion data) {
    return RideSegment(
      id: data.id.present ? data.id.value : this.id,
      rideId: data.rideId.present ? data.rideId.value : this.rideId,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RideSegment(')
          ..write('id: $id, ')
          ..write('rideId: $rideId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, rideId, startedAt, endedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RideSegment &&
          other.id == this.id &&
          other.rideId == this.rideId &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt);
}

class RideSegmentsCompanion extends UpdateCompanion<RideSegment> {
  final Value<int> id;
  final Value<int> rideId;
  final Value<int> startedAt;
  final Value<int?> endedAt;
  const RideSegmentsCompanion({
    this.id = const Value.absent(),
    this.rideId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
  });
  RideSegmentsCompanion.insert({
    this.id = const Value.absent(),
    required int rideId,
    required int startedAt,
    this.endedAt = const Value.absent(),
  }) : rideId = Value(rideId),
       startedAt = Value(startedAt);
  static Insertable<RideSegment> custom({
    Expression<int>? id,
    Expression<int>? rideId,
    Expression<int>? startedAt,
    Expression<int>? endedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rideId != null) 'ride_id': rideId,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
    });
  }

  RideSegmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? rideId,
    Value<int>? startedAt,
    Value<int?>? endedAt,
  }) {
    return RideSegmentsCompanion(
      id: id ?? this.id,
      rideId: rideId ?? this.rideId,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rideId.present) {
      map['ride_id'] = Variable<int>(rideId.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<int>(endedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RideSegmentsCompanion(')
          ..write('id: $id, ')
          ..write('rideId: $rideId, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt')
          ..write(')'))
        .toString();
  }
}

class $TrackPointsTable extends TrackPoints
    with TableInfo<$TrackPointsTable, TrackPoint> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrackPointsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rideIdMeta = const VerificationMeta('rideId');
  @override
  late final GeneratedColumn<int> rideId = GeneratedColumn<int>(
    'ride_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES rides (id)',
    ),
  );
  static const VerificationMeta _segmentIdMeta = const VerificationMeta(
    'segmentId',
  );
  @override
  late final GeneratedColumn<int> segmentId = GeneratedColumn<int>(
    'segment_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ride_segments (id)',
    ),
  );
  static const VerificationMeta _tsMeta = const VerificationMeta('ts');
  @override
  late final GeneratedColumn<int> ts = GeneratedColumn<int>(
    'ts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMeta = const VerificationMeta(
    'altitude',
  );
  @override
  late final GeneratedColumn<double> altitude = GeneratedColumn<double>(
    'altitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMeta = const VerificationMeta(
    'accuracy',
  );
  @override
  late final GeneratedColumn<double> accuracy = GeneratedColumn<double>(
    'accuracy',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speedMpsMeta = const VerificationMeta(
    'speedMps',
  );
  @override
  late final GeneratedColumn<double> speedMps = GeneratedColumn<double>(
    'speed_mps',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    rideId,
    segmentId,
    ts,
    lat,
    lon,
    altitude,
    accuracy,
    speedMps,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'track_points';
  @override
  VerificationContext validateIntegrity(
    Insertable<TrackPoint> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ride_id')) {
      context.handle(
        _rideIdMeta,
        rideId.isAcceptableOrUnknown(data['ride_id']!, _rideIdMeta),
      );
    } else if (isInserting) {
      context.missing(_rideIdMeta);
    }
    if (data.containsKey('segment_id')) {
      context.handle(
        _segmentIdMeta,
        segmentId.isAcceptableOrUnknown(data['segment_id']!, _segmentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentIdMeta);
    }
    if (data.containsKey('ts')) {
      context.handle(_tsMeta, ts.isAcceptableOrUnknown(data['ts']!, _tsMeta));
    } else if (isInserting) {
      context.missing(_tsMeta);
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    } else if (isInserting) {
      context.missing(_latMeta);
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    } else if (isInserting) {
      context.missing(_lonMeta);
    }
    if (data.containsKey('altitude')) {
      context.handle(
        _altitudeMeta,
        altitude.isAcceptableOrUnknown(data['altitude']!, _altitudeMeta),
      );
    }
    if (data.containsKey('accuracy')) {
      context.handle(
        _accuracyMeta,
        accuracy.isAcceptableOrUnknown(data['accuracy']!, _accuracyMeta),
      );
    } else if (isInserting) {
      context.missing(_accuracyMeta);
    }
    if (data.containsKey('speed_mps')) {
      context.handle(
        _speedMpsMeta,
        speedMps.isAcceptableOrUnknown(data['speed_mps']!, _speedMpsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TrackPoint map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TrackPoint(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      rideId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ride_id'],
      )!,
      segmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}segment_id'],
      )!,
      ts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ts'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      )!,
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      )!,
      altitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude'],
      ),
      accuracy: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy'],
      )!,
      speedMps: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}speed_mps'],
      ),
    );
  }

  @override
  $TrackPointsTable createAlias(String alias) {
    return $TrackPointsTable(attachedDatabase, alias);
  }
}

class TrackPoint extends DataClass implements Insertable<TrackPoint> {
  final int id;
  final int rideId;
  final int segmentId;
  final int ts;
  final double lat;
  final double lon;
  final double? altitude;
  final double accuracy;
  final double? speedMps;
  const TrackPoint({
    required this.id,
    required this.rideId,
    required this.segmentId,
    required this.ts,
    required this.lat,
    required this.lon,
    this.altitude,
    required this.accuracy,
    this.speedMps,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ride_id'] = Variable<int>(rideId);
    map['segment_id'] = Variable<int>(segmentId);
    map['ts'] = Variable<int>(ts);
    map['lat'] = Variable<double>(lat);
    map['lon'] = Variable<double>(lon);
    if (!nullToAbsent || altitude != null) {
      map['altitude'] = Variable<double>(altitude);
    }
    map['accuracy'] = Variable<double>(accuracy);
    if (!nullToAbsent || speedMps != null) {
      map['speed_mps'] = Variable<double>(speedMps);
    }
    return map;
  }

  TrackPointsCompanion toCompanion(bool nullToAbsent) {
    return TrackPointsCompanion(
      id: Value(id),
      rideId: Value(rideId),
      segmentId: Value(segmentId),
      ts: Value(ts),
      lat: Value(lat),
      lon: Value(lon),
      altitude: altitude == null && nullToAbsent
          ? const Value.absent()
          : Value(altitude),
      accuracy: Value(accuracy),
      speedMps: speedMps == null && nullToAbsent
          ? const Value.absent()
          : Value(speedMps),
    );
  }

  factory TrackPoint.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TrackPoint(
      id: serializer.fromJson<int>(json['id']),
      rideId: serializer.fromJson<int>(json['rideId']),
      segmentId: serializer.fromJson<int>(json['segmentId']),
      ts: serializer.fromJson<int>(json['ts']),
      lat: serializer.fromJson<double>(json['lat']),
      lon: serializer.fromJson<double>(json['lon']),
      altitude: serializer.fromJson<double?>(json['altitude']),
      accuracy: serializer.fromJson<double>(json['accuracy']),
      speedMps: serializer.fromJson<double?>(json['speedMps']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rideId': serializer.toJson<int>(rideId),
      'segmentId': serializer.toJson<int>(segmentId),
      'ts': serializer.toJson<int>(ts),
      'lat': serializer.toJson<double>(lat),
      'lon': serializer.toJson<double>(lon),
      'altitude': serializer.toJson<double?>(altitude),
      'accuracy': serializer.toJson<double>(accuracy),
      'speedMps': serializer.toJson<double?>(speedMps),
    };
  }

  TrackPoint copyWith({
    int? id,
    int? rideId,
    int? segmentId,
    int? ts,
    double? lat,
    double? lon,
    Value<double?> altitude = const Value.absent(),
    double? accuracy,
    Value<double?> speedMps = const Value.absent(),
  }) => TrackPoint(
    id: id ?? this.id,
    rideId: rideId ?? this.rideId,
    segmentId: segmentId ?? this.segmentId,
    ts: ts ?? this.ts,
    lat: lat ?? this.lat,
    lon: lon ?? this.lon,
    altitude: altitude.present ? altitude.value : this.altitude,
    accuracy: accuracy ?? this.accuracy,
    speedMps: speedMps.present ? speedMps.value : this.speedMps,
  );
  TrackPoint copyWithCompanion(TrackPointsCompanion data) {
    return TrackPoint(
      id: data.id.present ? data.id.value : this.id,
      rideId: data.rideId.present ? data.rideId.value : this.rideId,
      segmentId: data.segmentId.present ? data.segmentId.value : this.segmentId,
      ts: data.ts.present ? data.ts.value : this.ts,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      altitude: data.altitude.present ? data.altitude.value : this.altitude,
      accuracy: data.accuracy.present ? data.accuracy.value : this.accuracy,
      speedMps: data.speedMps.present ? data.speedMps.value : this.speedMps,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TrackPoint(')
          ..write('id: $id, ')
          ..write('rideId: $rideId, ')
          ..write('segmentId: $segmentId, ')
          ..write('ts: $ts, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('altitude: $altitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('speedMps: $speedMps')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    rideId,
    segmentId,
    ts,
    lat,
    lon,
    altitude,
    accuracy,
    speedMps,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TrackPoint &&
          other.id == this.id &&
          other.rideId == this.rideId &&
          other.segmentId == this.segmentId &&
          other.ts == this.ts &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.altitude == this.altitude &&
          other.accuracy == this.accuracy &&
          other.speedMps == this.speedMps);
}

class TrackPointsCompanion extends UpdateCompanion<TrackPoint> {
  final Value<int> id;
  final Value<int> rideId;
  final Value<int> segmentId;
  final Value<int> ts;
  final Value<double> lat;
  final Value<double> lon;
  final Value<double?> altitude;
  final Value<double> accuracy;
  final Value<double?> speedMps;
  const TrackPointsCompanion({
    this.id = const Value.absent(),
    this.rideId = const Value.absent(),
    this.segmentId = const Value.absent(),
    this.ts = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.altitude = const Value.absent(),
    this.accuracy = const Value.absent(),
    this.speedMps = const Value.absent(),
  });
  TrackPointsCompanion.insert({
    this.id = const Value.absent(),
    required int rideId,
    required int segmentId,
    required int ts,
    required double lat,
    required double lon,
    this.altitude = const Value.absent(),
    required double accuracy,
    this.speedMps = const Value.absent(),
  }) : rideId = Value(rideId),
       segmentId = Value(segmentId),
       ts = Value(ts),
       lat = Value(lat),
       lon = Value(lon),
       accuracy = Value(accuracy);
  static Insertable<TrackPoint> custom({
    Expression<int>? id,
    Expression<int>? rideId,
    Expression<int>? segmentId,
    Expression<int>? ts,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<double>? altitude,
    Expression<double>? accuracy,
    Expression<double>? speedMps,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rideId != null) 'ride_id': rideId,
      if (segmentId != null) 'segment_id': segmentId,
      if (ts != null) 'ts': ts,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (altitude != null) 'altitude': altitude,
      if (accuracy != null) 'accuracy': accuracy,
      if (speedMps != null) 'speed_mps': speedMps,
    });
  }

  TrackPointsCompanion copyWith({
    Value<int>? id,
    Value<int>? rideId,
    Value<int>? segmentId,
    Value<int>? ts,
    Value<double>? lat,
    Value<double>? lon,
    Value<double?>? altitude,
    Value<double>? accuracy,
    Value<double?>? speedMps,
  }) {
    return TrackPointsCompanion(
      id: id ?? this.id,
      rideId: rideId ?? this.rideId,
      segmentId: segmentId ?? this.segmentId,
      ts: ts ?? this.ts,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      altitude: altitude ?? this.altitude,
      accuracy: accuracy ?? this.accuracy,
      speedMps: speedMps ?? this.speedMps,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rideId.present) {
      map['ride_id'] = Variable<int>(rideId.value);
    }
    if (segmentId.present) {
      map['segment_id'] = Variable<int>(segmentId.value);
    }
    if (ts.present) {
      map['ts'] = Variable<int>(ts.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (altitude.present) {
      map['altitude'] = Variable<double>(altitude.value);
    }
    if (accuracy.present) {
      map['accuracy'] = Variable<double>(accuracy.value);
    }
    if (speedMps.present) {
      map['speed_mps'] = Variable<double>(speedMps.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrackPointsCompanion(')
          ..write('id: $id, ')
          ..write('rideId: $rideId, ')
          ..write('segmentId: $segmentId, ')
          ..write('ts: $ts, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('altitude: $altitude, ')
          ..write('accuracy: $accuracy, ')
          ..write('speedMps: $speedMps')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RidesTable rides = $RidesTable(this);
  late final $RideSegmentsTable rideSegments = $RideSegmentsTable(this);
  late final $TrackPointsTable trackPoints = $TrackPointsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    rides,
    rideSegments,
    trackPoints,
  ];
}

typedef $$RidesTableCreateCompanionBuilder =
    RidesCompanion Function({
      Value<int> id,
      required int startedAt,
      Value<int?> endedAt,
      required RideStatus status,
      Value<double> distanceMeters,
      Value<int> movingTimeMs,
      Value<int> elapsedTimeMs,
      Value<double> maxSpeedMps,
      Value<double> avgSpeedMps,
    });
typedef $$RidesTableUpdateCompanionBuilder =
    RidesCompanion Function({
      Value<int> id,
      Value<int> startedAt,
      Value<int?> endedAt,
      Value<RideStatus> status,
      Value<double> distanceMeters,
      Value<int> movingTimeMs,
      Value<int> elapsedTimeMs,
      Value<double> maxSpeedMps,
      Value<double> avgSpeedMps,
    });

final class $$RidesTableReferences
    extends BaseReferences<_$AppDatabase, $RidesTable, Ride> {
  $$RidesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RideSegmentsTable, List<RideSegment>>
  _rideSegmentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.rideSegments,
    aliasName: 'rides__id__ride_segments__ride_id',
  );

  $$RideSegmentsTableProcessedTableManager get rideSegmentsRefs {
    final manager = $$RideSegmentsTableTableManager(
      $_db,
      $_db.rideSegments,
    ).filter((f) => f.rideId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_rideSegmentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TrackPointsTable, List<TrackPoint>>
  _trackPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trackPoints,
    aliasName: 'rides__id__track_points__ride_id',
  );

  $$TrackPointsTableProcessedTableManager get trackPointsRefs {
    final manager = $$TrackPointsTableTableManager(
      $_db,
      $_db.trackPoints,
    ).filter((f) => f.rideId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trackPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RidesTableFilterComposer extends Composer<_$AppDatabase, $RidesTable> {
  $$RidesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RideStatus, RideStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get movingTimeMs => $composableBuilder(
    column: $table.movingTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get elapsedTimeMs => $composableBuilder(
    column: $table.elapsedTimeMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> rideSegmentsRefs(
    Expression<bool> Function($$RideSegmentsTableFilterComposer f) f,
  ) {
    final $$RideSegmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rideSegments,
      getReferencedColumn: (t) => t.rideId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideSegmentsTableFilterComposer(
            $db: $db,
            $table: $db.rideSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> trackPointsRefs(
    Expression<bool> Function($$TrackPointsTableFilterComposer f) f,
  ) {
    final $$TrackPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackPoints,
      getReferencedColumn: (t) => t.rideId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackPointsTableFilterComposer(
            $db: $db,
            $table: $db.trackPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RidesTableOrderingComposer
    extends Composer<_$AppDatabase, $RidesTable> {
  $$RidesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get movingTimeMs => $composableBuilder(
    column: $table.movingTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get elapsedTimeMs => $composableBuilder(
    column: $table.elapsedTimeMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RidesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RidesTable> {
  $$RidesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RideStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => column,
  );

  GeneratedColumn<int> get movingTimeMs => $composableBuilder(
    column: $table.movingTimeMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get elapsedTimeMs => $composableBuilder(
    column: $table.elapsedTimeMs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSpeedMps => $composableBuilder(
    column: $table.maxSpeedMps,
    builder: (column) => column,
  );

  GeneratedColumn<double> get avgSpeedMps => $composableBuilder(
    column: $table.avgSpeedMps,
    builder: (column) => column,
  );

  Expression<T> rideSegmentsRefs<T extends Object>(
    Expression<T> Function($$RideSegmentsTableAnnotationComposer a) f,
  ) {
    final $$RideSegmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.rideSegments,
      getReferencedColumn: (t) => t.rideId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideSegmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.rideSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> trackPointsRefs<T extends Object>(
    Expression<T> Function($$TrackPointsTableAnnotationComposer a) f,
  ) {
    final $$TrackPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackPoints,
      getReferencedColumn: (t) => t.rideId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.trackPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RidesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RidesTable,
          Ride,
          $$RidesTableFilterComposer,
          $$RidesTableOrderingComposer,
          $$RidesTableAnnotationComposer,
          $$RidesTableCreateCompanionBuilder,
          $$RidesTableUpdateCompanionBuilder,
          (Ride, $$RidesTableReferences),
          Ride,
          PrefetchHooks Function({bool rideSegmentsRefs, bool trackPointsRefs})
        > {
  $$RidesTableTableManager(_$AppDatabase db, $RidesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RidesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RidesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RidesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> endedAt = const Value.absent(),
                Value<RideStatus> status = const Value.absent(),
                Value<double> distanceMeters = const Value.absent(),
                Value<int> movingTimeMs = const Value.absent(),
                Value<int> elapsedTimeMs = const Value.absent(),
                Value<double> maxSpeedMps = const Value.absent(),
                Value<double> avgSpeedMps = const Value.absent(),
              }) => RidesCompanion(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                distanceMeters: distanceMeters,
                movingTimeMs: movingTimeMs,
                elapsedTimeMs: elapsedTimeMs,
                maxSpeedMps: maxSpeedMps,
                avgSpeedMps: avgSpeedMps,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int startedAt,
                Value<int?> endedAt = const Value.absent(),
                required RideStatus status,
                Value<double> distanceMeters = const Value.absent(),
                Value<int> movingTimeMs = const Value.absent(),
                Value<int> elapsedTimeMs = const Value.absent(),
                Value<double> maxSpeedMps = const Value.absent(),
                Value<double> avgSpeedMps = const Value.absent(),
              }) => RidesCompanion.insert(
                id: id,
                startedAt: startedAt,
                endedAt: endedAt,
                status: status,
                distanceMeters: distanceMeters,
                movingTimeMs: movingTimeMs,
                elapsedTimeMs: elapsedTimeMs,
                maxSpeedMps: maxSpeedMps,
                avgSpeedMps: avgSpeedMps,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RidesTable, Ride>(table),
                  $$RidesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({rideSegmentsRefs = false, trackPointsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (rideSegmentsRefs) db.rideSegments,
                    if (trackPointsRefs) db.trackPoints,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (rideSegmentsRefs)
                        await $_getPrefetchedData<
                          Ride,
                          $RidesTable,
                          RideSegment
                        >(
                          currentTable: table,
                          referencedTable: $$RidesTableReferences
                              ._rideSegmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RidesTableReferences(
                                db,
                                table,
                                p0,
                              ).rideSegmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rideId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (trackPointsRefs)
                        await $_getPrefetchedData<
                          Ride,
                          $RidesTable,
                          TrackPoint
                        >(
                          currentTable: table,
                          referencedTable: $$RidesTableReferences
                              ._trackPointsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RidesTableReferences(
                                db,
                                table,
                                p0,
                              ).trackPointsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.rideId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RidesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RidesTable,
      Ride,
      $$RidesTableFilterComposer,
      $$RidesTableOrderingComposer,
      $$RidesTableAnnotationComposer,
      $$RidesTableCreateCompanionBuilder,
      $$RidesTableUpdateCompanionBuilder,
      (Ride, $$RidesTableReferences),
      Ride,
      PrefetchHooks Function({bool rideSegmentsRefs, bool trackPointsRefs})
    >;
typedef $$RideSegmentsTableCreateCompanionBuilder =
    RideSegmentsCompanion Function({
      Value<int> id,
      required int rideId,
      required int startedAt,
      Value<int?> endedAt,
    });
typedef $$RideSegmentsTableUpdateCompanionBuilder =
    RideSegmentsCompanion Function({
      Value<int> id,
      Value<int> rideId,
      Value<int> startedAt,
      Value<int?> endedAt,
    });

final class $$RideSegmentsTableReferences
    extends BaseReferences<_$AppDatabase, $RideSegmentsTable, RideSegment> {
  $$RideSegmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RidesTable _rideIdTable(_$AppDatabase db) =>
      db.rides.createAlias('ride_segments__ride_id__rides__id');

  $$RidesTableProcessedTableManager get rideId {
    final $_column = $_itemColumn<int>('ride_id')!;

    final manager = $$RidesTableTableManager(
      $_db,
      $_db.rides,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rideIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TrackPointsTable, List<TrackPoint>>
  _trackPointsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.trackPoints,
    aliasName: 'ride_segments__id__track_points__segment_id',
  );

  $$TrackPointsTableProcessedTableManager get trackPointsRefs {
    final manager = $$TrackPointsTableTableManager(
      $_db,
      $_db.trackPoints,
    ).filter((f) => f.segmentId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trackPointsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RideSegmentsTableFilterComposer
    extends Composer<_$AppDatabase, $RideSegmentsTable> {
  $$RideSegmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RidesTableFilterComposer get rideId {
    final $$RidesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rideId,
      referencedTable: $db.rides,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RidesTableFilterComposer(
            $db: $db,
            $table: $db.rides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> trackPointsRefs(
    Expression<bool> Function($$TrackPointsTableFilterComposer f) f,
  ) {
    final $$TrackPointsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackPoints,
      getReferencedColumn: (t) => t.segmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackPointsTableFilterComposer(
            $db: $db,
            $table: $db.trackPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RideSegmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $RideSegmentsTable> {
  $$RideSegmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endedAt => $composableBuilder(
    column: $table.endedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RidesTableOrderingComposer get rideId {
    final $$RidesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rideId,
      referencedTable: $db.rides,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RidesTableOrderingComposer(
            $db: $db,
            $table: $db.rides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RideSegmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RideSegmentsTable> {
  $$RideSegmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  $$RidesTableAnnotationComposer get rideId {
    final $$RidesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rideId,
      referencedTable: $db.rides,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RidesTableAnnotationComposer(
            $db: $db,
            $table: $db.rides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> trackPointsRefs<T extends Object>(
    Expression<T> Function($$TrackPointsTableAnnotationComposer a) f,
  ) {
    final $$TrackPointsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trackPoints,
      getReferencedColumn: (t) => t.segmentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrackPointsTableAnnotationComposer(
            $db: $db,
            $table: $db.trackPoints,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RideSegmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RideSegmentsTable,
          RideSegment,
          $$RideSegmentsTableFilterComposer,
          $$RideSegmentsTableOrderingComposer,
          $$RideSegmentsTableAnnotationComposer,
          $$RideSegmentsTableCreateCompanionBuilder,
          $$RideSegmentsTableUpdateCompanionBuilder,
          (RideSegment, $$RideSegmentsTableReferences),
          RideSegment,
          PrefetchHooks Function({bool rideId, bool trackPointsRefs})
        > {
  $$RideSegmentsTableTableManager(_$AppDatabase db, $RideSegmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RideSegmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RideSegmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RideSegmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> rideId = const Value.absent(),
                Value<int> startedAt = const Value.absent(),
                Value<int?> endedAt = const Value.absent(),
              }) => RideSegmentsCompanion(
                id: id,
                rideId: rideId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int rideId,
                required int startedAt,
                Value<int?> endedAt = const Value.absent(),
              }) => RideSegmentsCompanion.insert(
                id: id,
                rideId: rideId,
                startedAt: startedAt,
                endedAt: endedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RideSegmentsTable, RideSegment>(table),
                  $$RideSegmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rideId = false, trackPointsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (trackPointsRefs) db.trackPoints],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (rideId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.rideId,
                                referencedTable: $$RideSegmentsTableReferences
                                    ._rideIdTable(db),
                                referencedColumn: $$RideSegmentsTableReferences
                                    ._rideIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trackPointsRefs)
                    await $_getPrefetchedData<
                      RideSegment,
                      $RideSegmentsTable,
                      TrackPoint
                    >(
                      currentTable: table,
                      referencedTable: $$RideSegmentsTableReferences
                          ._trackPointsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RideSegmentsTableReferences(
                            db,
                            table,
                            p0,
                          ).trackPointsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.segmentId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RideSegmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RideSegmentsTable,
      RideSegment,
      $$RideSegmentsTableFilterComposer,
      $$RideSegmentsTableOrderingComposer,
      $$RideSegmentsTableAnnotationComposer,
      $$RideSegmentsTableCreateCompanionBuilder,
      $$RideSegmentsTableUpdateCompanionBuilder,
      (RideSegment, $$RideSegmentsTableReferences),
      RideSegment,
      PrefetchHooks Function({bool rideId, bool trackPointsRefs})
    >;
typedef $$TrackPointsTableCreateCompanionBuilder =
    TrackPointsCompanion Function({
      Value<int> id,
      required int rideId,
      required int segmentId,
      required int ts,
      required double lat,
      required double lon,
      Value<double?> altitude,
      required double accuracy,
      Value<double?> speedMps,
    });
typedef $$TrackPointsTableUpdateCompanionBuilder =
    TrackPointsCompanion Function({
      Value<int> id,
      Value<int> rideId,
      Value<int> segmentId,
      Value<int> ts,
      Value<double> lat,
      Value<double> lon,
      Value<double?> altitude,
      Value<double> accuracy,
      Value<double?> speedMps,
    });

final class $$TrackPointsTableReferences
    extends BaseReferences<_$AppDatabase, $TrackPointsTable, TrackPoint> {
  $$TrackPointsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RidesTable _rideIdTable(_$AppDatabase db) =>
      db.rides.createAlias('track_points__ride_id__rides__id');

  $$RidesTableProcessedTableManager get rideId {
    final $_column = $_itemColumn<int>('ride_id')!;

    final manager = $$RidesTableTableManager(
      $_db,
      $_db.rides,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_rideIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RideSegmentsTable _segmentIdTable(_$AppDatabase db) => db.rideSegments
      .createAlias('track_points__segment_id__ride_segments__id');

  $$RideSegmentsTableProcessedTableManager get segmentId {
    final $_column = $_itemColumn<int>('segment_id')!;

    final manager = $$RideSegmentsTableTableManager(
      $_db,
      $_db.rideSegments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_segmentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrackPointsTableFilterComposer
    extends Composer<_$AppDatabase, $TrackPointsTable> {
  $$TrackPointsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnFilters(column),
  );

  $$RidesTableFilterComposer get rideId {
    final $$RidesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rideId,
      referencedTable: $db.rides,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RidesTableFilterComposer(
            $db: $db,
            $table: $db.rides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RideSegmentsTableFilterComposer get segmentId {
    final $$RideSegmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.segmentId,
      referencedTable: $db.rideSegments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideSegmentsTableFilterComposer(
            $db: $db,
            $table: $db.rideSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackPointsTableOrderingComposer
    extends Composer<_$AppDatabase, $TrackPointsTable> {
  $$TrackPointsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ts => $composableBuilder(
    column: $table.ts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitude => $composableBuilder(
    column: $table.altitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracy => $composableBuilder(
    column: $table.accuracy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get speedMps => $composableBuilder(
    column: $table.speedMps,
    builder: (column) => ColumnOrderings(column),
  );

  $$RidesTableOrderingComposer get rideId {
    final $$RidesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rideId,
      referencedTable: $db.rides,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RidesTableOrderingComposer(
            $db: $db,
            $table: $db.rides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RideSegmentsTableOrderingComposer get segmentId {
    final $$RideSegmentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.segmentId,
      referencedTable: $db.rideSegments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideSegmentsTableOrderingComposer(
            $db: $db,
            $table: $db.rideSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackPointsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrackPointsTable> {
  $$TrackPointsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ts =>
      $composableBuilder(column: $table.ts, builder: (column) => column);

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<double> get altitude =>
      $composableBuilder(column: $table.altitude, builder: (column) => column);

  GeneratedColumn<double> get accuracy =>
      $composableBuilder(column: $table.accuracy, builder: (column) => column);

  GeneratedColumn<double> get speedMps =>
      $composableBuilder(column: $table.speedMps, builder: (column) => column);

  $$RidesTableAnnotationComposer get rideId {
    final $$RidesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.rideId,
      referencedTable: $db.rides,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RidesTableAnnotationComposer(
            $db: $db,
            $table: $db.rides,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RideSegmentsTableAnnotationComposer get segmentId {
    final $$RideSegmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.segmentId,
      referencedTable: $db.rideSegments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RideSegmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.rideSegments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrackPointsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrackPointsTable,
          TrackPoint,
          $$TrackPointsTableFilterComposer,
          $$TrackPointsTableOrderingComposer,
          $$TrackPointsTableAnnotationComposer,
          $$TrackPointsTableCreateCompanionBuilder,
          $$TrackPointsTableUpdateCompanionBuilder,
          (TrackPoint, $$TrackPointsTableReferences),
          TrackPoint,
          PrefetchHooks Function({bool rideId, bool segmentId})
        > {
  $$TrackPointsTableTableManager(_$AppDatabase db, $TrackPointsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrackPointsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrackPointsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrackPointsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> rideId = const Value.absent(),
                Value<int> segmentId = const Value.absent(),
                Value<int> ts = const Value.absent(),
                Value<double> lat = const Value.absent(),
                Value<double> lon = const Value.absent(),
                Value<double?> altitude = const Value.absent(),
                Value<double> accuracy = const Value.absent(),
                Value<double?> speedMps = const Value.absent(),
              }) => TrackPointsCompanion(
                id: id,
                rideId: rideId,
                segmentId: segmentId,
                ts: ts,
                lat: lat,
                lon: lon,
                altitude: altitude,
                accuracy: accuracy,
                speedMps: speedMps,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int rideId,
                required int segmentId,
                required int ts,
                required double lat,
                required double lon,
                Value<double?> altitude = const Value.absent(),
                required double accuracy,
                Value<double?> speedMps = const Value.absent(),
              }) => TrackPointsCompanion.insert(
                id: id,
                rideId: rideId,
                segmentId: segmentId,
                ts: ts,
                lat: lat,
                lon: lon,
                altitude: altitude,
                accuracy: accuracy,
                speedMps: speedMps,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrackPointsTable, TrackPoint>(table),
                  $$TrackPointsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({rideId = false, segmentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (rideId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.rideId,
                                referencedTable: $$TrackPointsTableReferences
                                    ._rideIdTable(db),
                                referencedColumn: $$TrackPointsTableReferences
                                    ._rideIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (segmentId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.segmentId,
                                referencedTable: $$TrackPointsTableReferences
                                    ._segmentIdTable(db),
                                referencedColumn: $$TrackPointsTableReferences
                                    ._segmentIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrackPointsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrackPointsTable,
      TrackPoint,
      $$TrackPointsTableFilterComposer,
      $$TrackPointsTableOrderingComposer,
      $$TrackPointsTableAnnotationComposer,
      $$TrackPointsTableCreateCompanionBuilder,
      $$TrackPointsTableUpdateCompanionBuilder,
      (TrackPoint, $$TrackPointsTableReferences),
      TrackPoint,
      PrefetchHooks Function({bool rideId, bool segmentId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RidesTableTableManager get rides =>
      $$RidesTableTableManager(_db, _db.rides);
  $$RideSegmentsTableTableManager get rideSegments =>
      $$RideSegmentsTableTableManager(_db, _db.rideSegments);
  $$TrackPointsTableTableManager get trackPoints =>
      $$TrackPointsTableTableManager(_db, _db.trackPoints);
}
