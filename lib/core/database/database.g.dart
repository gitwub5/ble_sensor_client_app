// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RefrigeratorsTable extends Refrigerators
    with TableInfo<$RefrigeratorsTable, Refrigerator> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RefrigeratorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, location];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'refrigerators';
  @override
  VerificationContext validateIntegrity(Insertable<Refrigerator> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Refrigerator map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Refrigerator(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location'])!,
    );
  }

  @override
  $RefrigeratorsTable createAlias(String alias) {
    return $RefrigeratorsTable(attachedDatabase, alias);
  }
}

class Refrigerator extends DataClass implements Insertable<Refrigerator> {
  final int id;
  final String name;
  final String location;
  const Refrigerator(
      {required this.id, required this.name, required this.location});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['location'] = Variable<String>(location);
    return map;
  }

  RefrigeratorsCompanion toCompanion(bool nullToAbsent) {
    return RefrigeratorsCompanion(
      id: Value(id),
      name: Value(name),
      location: Value(location),
    );
  }

  factory Refrigerator.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Refrigerator(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      location: serializer.fromJson<String>(json['location']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'location': serializer.toJson<String>(location),
    };
  }

  Refrigerator copyWith({int? id, String? name, String? location}) =>
      Refrigerator(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
      );
  Refrigerator copyWithCompanion(RefrigeratorsCompanion data) {
    return Refrigerator(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      location: data.location.present ? data.location.value : this.location,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Refrigerator(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, location);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Refrigerator &&
          other.id == this.id &&
          other.name == this.name &&
          other.location == this.location);
}

class RefrigeratorsCompanion extends UpdateCompanion<Refrigerator> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> location;
  const RefrigeratorsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.location = const Value.absent(),
  });
  RefrigeratorsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String location,
  })  : name = Value(name),
        location = Value(location);
  static Insertable<Refrigerator> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? location,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (location != null) 'location': location,
    });
  }

  RefrigeratorsCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<String>? location}) {
    return RefrigeratorsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      location: location ?? this.location,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RefrigeratorsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('location: $location')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _deviceAddressMeta =
      const VerificationMeta('deviceAddress');
  @override
  late final GeneratedColumn<String> deviceAddress = GeneratedColumn<String>(
      'device_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _sensorPeriodMeta =
      const VerificationMeta('sensorPeriod');
  @override
  late final GeneratedColumn<String> sensorPeriod = GeneratedColumn<String>(
      'sensor_period', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
      'last_update', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _refrigeratorIdMeta =
      const VerificationMeta('refrigeratorId');
  @override
  late final GeneratedColumn<int> refrigeratorId = GeneratedColumn<int>(
      'refrigerator_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES refrigerators (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, uid, deviceAddress, name, sensorPeriod, lastUpdate, refrigeratorId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('device_address')) {
      context.handle(
          _deviceAddressMeta,
          deviceAddress.isAcceptableOrUnknown(
              data['device_address']!, _deviceAddressMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sensor_period')) {
      context.handle(
          _sensorPeriodMeta,
          sensorPeriod.isAcceptableOrUnknown(
              data['sensor_period']!, _sensorPeriodMeta));
    } else if (isInserting) {
      context.missing(_sensorPeriodMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    }
    if (data.containsKey('refrigerator_id')) {
      context.handle(
          _refrigeratorIdMeta,
          refrigeratorId.isAcceptableOrUnknown(
              data['refrigerator_id']!, _refrigeratorIdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      deviceAddress: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_address']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      sensorPeriod: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sensor_period'])!,
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_update']),
      refrigeratorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}refrigerator_id']),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final int id;
  final String uid;
  final String? deviceAddress;
  final String name;
  final String sensorPeriod;
  final DateTime? lastUpdate;
  final int? refrigeratorId;
  const Tag(
      {required this.id,
      required this.uid,
      this.deviceAddress,
      required this.name,
      required this.sensorPeriod,
      this.lastUpdate,
      this.refrigeratorId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uid'] = Variable<String>(uid);
    if (!nullToAbsent || deviceAddress != null) {
      map['device_address'] = Variable<String>(deviceAddress);
    }
    map['name'] = Variable<String>(name);
    map['sensor_period'] = Variable<String>(sensorPeriod);
    if (!nullToAbsent || lastUpdate != null) {
      map['last_update'] = Variable<DateTime>(lastUpdate);
    }
    if (!nullToAbsent || refrigeratorId != null) {
      map['refrigerator_id'] = Variable<int>(refrigeratorId);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      uid: Value(uid),
      deviceAddress: deviceAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceAddress),
      name: Value(name),
      sensorPeriod: Value(sensorPeriod),
      lastUpdate: lastUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdate),
      refrigeratorId: refrigeratorId == null && nullToAbsent
          ? const Value.absent()
          : Value(refrigeratorId),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<int>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      deviceAddress: serializer.fromJson<String?>(json['deviceAddress']),
      name: serializer.fromJson<String>(json['name']),
      sensorPeriod: serializer.fromJson<String>(json['sensorPeriod']),
      lastUpdate: serializer.fromJson<DateTime?>(json['lastUpdate']),
      refrigeratorId: serializer.fromJson<int?>(json['refrigeratorId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'uid': serializer.toJson<String>(uid),
      'deviceAddress': serializer.toJson<String?>(deviceAddress),
      'name': serializer.toJson<String>(name),
      'sensorPeriod': serializer.toJson<String>(sensorPeriod),
      'lastUpdate': serializer.toJson<DateTime?>(lastUpdate),
      'refrigeratorId': serializer.toJson<int?>(refrigeratorId),
    };
  }

  Tag copyWith(
          {int? id,
          String? uid,
          Value<String?> deviceAddress = const Value.absent(),
          String? name,
          String? sensorPeriod,
          Value<DateTime?> lastUpdate = const Value.absent(),
          Value<int?> refrigeratorId = const Value.absent()}) =>
      Tag(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        deviceAddress:
            deviceAddress.present ? deviceAddress.value : this.deviceAddress,
        name: name ?? this.name,
        sensorPeriod: sensorPeriod ?? this.sensorPeriod,
        lastUpdate: lastUpdate.present ? lastUpdate.value : this.lastUpdate,
        refrigeratorId:
            refrigeratorId.present ? refrigeratorId.value : this.refrigeratorId,
      );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      deviceAddress: data.deviceAddress.present
          ? data.deviceAddress.value
          : this.deviceAddress,
      name: data.name.present ? data.name.value : this.name,
      sensorPeriod: data.sensorPeriod.present
          ? data.sensorPeriod.value
          : this.sensorPeriod,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
      refrigeratorId: data.refrigeratorId.present
          ? data.refrigeratorId.value
          : this.refrigeratorId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('name: $name, ')
          ..write('sensorPeriod: $sensorPeriod, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('refrigeratorId: $refrigeratorId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, uid, deviceAddress, name, sensorPeriod, lastUpdate, refrigeratorId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.deviceAddress == this.deviceAddress &&
          other.name == this.name &&
          other.sensorPeriod == this.sensorPeriod &&
          other.lastUpdate == this.lastUpdate &&
          other.refrigeratorId == this.refrigeratorId);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<int> id;
  final Value<String> uid;
  final Value<String?> deviceAddress;
  final Value<String> name;
  final Value<String> sensorPeriod;
  final Value<DateTime?> lastUpdate;
  final Value<int?> refrigeratorId;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.deviceAddress = const Value.absent(),
    this.name = const Value.absent(),
    this.sensorPeriod = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.refrigeratorId = const Value.absent(),
  });
  TagsCompanion.insert({
    this.id = const Value.absent(),
    required String uid,
    this.deviceAddress = const Value.absent(),
    required String name,
    required String sensorPeriod,
    this.lastUpdate = const Value.absent(),
    this.refrigeratorId = const Value.absent(),
  })  : uid = Value(uid),
        name = Value(name),
        sensorPeriod = Value(sensorPeriod);
  static Insertable<Tag> custom({
    Expression<int>? id,
    Expression<String>? uid,
    Expression<String>? deviceAddress,
    Expression<String>? name,
    Expression<String>? sensorPeriod,
    Expression<DateTime>? lastUpdate,
    Expression<int>? refrigeratorId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (deviceAddress != null) 'device_address': deviceAddress,
      if (name != null) 'name': name,
      if (sensorPeriod != null) 'sensor_period': sensorPeriod,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (refrigeratorId != null) 'refrigerator_id': refrigeratorId,
    });
  }

  TagsCompanion copyWith(
      {Value<int>? id,
      Value<String>? uid,
      Value<String?>? deviceAddress,
      Value<String>? name,
      Value<String>? sensorPeriod,
      Value<DateTime?>? lastUpdate,
      Value<int?>? refrigeratorId}) {
    return TagsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      deviceAddress: deviceAddress ?? this.deviceAddress,
      name: name ?? this.name,
      sensorPeriod: sensorPeriod ?? this.sensorPeriod,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      refrigeratorId: refrigeratorId ?? this.refrigeratorId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (deviceAddress.present) {
      map['device_address'] = Variable<String>(deviceAddress.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sensorPeriod.present) {
      map['sensor_period'] = Variable<String>(sensorPeriod.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (refrigeratorId.present) {
      map['refrigerator_id'] = Variable<int>(refrigeratorId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('deviceAddress: $deviceAddress, ')
          ..write('name: $name, ')
          ..write('sensorPeriod: $sensorPeriod, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('refrigeratorId: $refrigeratorId')
          ..write(')'))
        .toString();
  }
}

class $TagDataTable extends TagData with TableInfo<$TagDataTable, TagDataData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tags (id)'));
  static const VerificationMeta _temperatureMeta =
      const VerificationMeta('temperature');
  @override
  late final GeneratedColumn<double> temperature = GeneratedColumn<double>(
      'temperature', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _humidityMeta =
      const VerificationMeta('humidity');
  @override
  late final GeneratedColumn<double> humidity = GeneratedColumn<double>(
      'humidity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _materialResistivityMeta =
      const VerificationMeta('materialResistivity');
  @override
  late final GeneratedColumn<double> materialResistivity =
      GeneratedColumn<double>('material_resistivity', aliasedName, false,
          type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, tagId, temperature, humidity, materialResistivity, measuredAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tag_data';
  @override
  VerificationContext validateIntegrity(Insertable<TagDataData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('temperature')) {
      context.handle(
          _temperatureMeta,
          temperature.isAcceptableOrUnknown(
              data['temperature']!, _temperatureMeta));
    } else if (isInserting) {
      context.missing(_temperatureMeta);
    }
    if (data.containsKey('humidity')) {
      context.handle(_humidityMeta,
          humidity.isAcceptableOrUnknown(data['humidity']!, _humidityMeta));
    } else if (isInserting) {
      context.missing(_humidityMeta);
    }
    if (data.containsKey('material_resistivity')) {
      context.handle(
          _materialResistivityMeta,
          materialResistivity.isAcceptableOrUnknown(
              data['material_resistivity']!, _materialResistivityMeta));
    } else if (isInserting) {
      context.missing(_materialResistivityMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagDataData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagDataData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      temperature: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}temperature'])!,
      humidity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}humidity'])!,
      materialResistivity: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}material_resistivity'])!,
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
    );
  }

  @override
  $TagDataTable createAlias(String alias) {
    return $TagDataTable(attachedDatabase, alias);
  }
}

class TagDataData extends DataClass implements Insertable<TagDataData> {
  final int id;
  final int tagId;
  final double temperature;
  final double humidity;
  final double materialResistivity;
  final DateTime measuredAt;
  const TagDataData(
      {required this.id,
      required this.tagId,
      required this.temperature,
      required this.humidity,
      required this.materialResistivity,
      required this.measuredAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag_id'] = Variable<int>(tagId);
    map['temperature'] = Variable<double>(temperature);
    map['humidity'] = Variable<double>(humidity);
    map['material_resistivity'] = Variable<double>(materialResistivity);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    return map;
  }

  TagDataCompanion toCompanion(bool nullToAbsent) {
    return TagDataCompanion(
      id: Value(id),
      tagId: Value(tagId),
      temperature: Value(temperature),
      humidity: Value(humidity),
      materialResistivity: Value(materialResistivity),
      measuredAt: Value(measuredAt),
    );
  }

  factory TagDataData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagDataData(
      id: serializer.fromJson<int>(json['id']),
      tagId: serializer.fromJson<int>(json['tagId']),
      temperature: serializer.fromJson<double>(json['temperature']),
      humidity: serializer.fromJson<double>(json['humidity']),
      materialResistivity:
          serializer.fromJson<double>(json['materialResistivity']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tagId': serializer.toJson<int>(tagId),
      'temperature': serializer.toJson<double>(temperature),
      'humidity': serializer.toJson<double>(humidity),
      'materialResistivity': serializer.toJson<double>(materialResistivity),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
    };
  }

  TagDataData copyWith(
          {int? id,
          int? tagId,
          double? temperature,
          double? humidity,
          double? materialResistivity,
          DateTime? measuredAt}) =>
      TagDataData(
        id: id ?? this.id,
        tagId: tagId ?? this.tagId,
        temperature: temperature ?? this.temperature,
        humidity: humidity ?? this.humidity,
        materialResistivity: materialResistivity ?? this.materialResistivity,
        measuredAt: measuredAt ?? this.measuredAt,
      );
  TagDataData copyWithCompanion(TagDataCompanion data) {
    return TagDataData(
      id: data.id.present ? data.id.value : this.id,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      temperature:
          data.temperature.present ? data.temperature.value : this.temperature,
      humidity: data.humidity.present ? data.humidity.value : this.humidity,
      materialResistivity: data.materialResistivity.present
          ? data.materialResistivity.value
          : this.materialResistivity,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TagDataData(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('materialResistivity: $materialResistivity, ')
          ..write('measuredAt: $measuredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, tagId, temperature, humidity, materialResistivity, measuredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagDataData &&
          other.id == this.id &&
          other.tagId == this.tagId &&
          other.temperature == this.temperature &&
          other.humidity == this.humidity &&
          other.materialResistivity == this.materialResistivity &&
          other.measuredAt == this.measuredAt);
}

class TagDataCompanion extends UpdateCompanion<TagDataData> {
  final Value<int> id;
  final Value<int> tagId;
  final Value<double> temperature;
  final Value<double> humidity;
  final Value<double> materialResistivity;
  final Value<DateTime> measuredAt;
  const TagDataCompanion({
    this.id = const Value.absent(),
    this.tagId = const Value.absent(),
    this.temperature = const Value.absent(),
    this.humidity = const Value.absent(),
    this.materialResistivity = const Value.absent(),
    this.measuredAt = const Value.absent(),
  });
  TagDataCompanion.insert({
    this.id = const Value.absent(),
    required int tagId,
    required double temperature,
    required double humidity,
    required double materialResistivity,
    this.measuredAt = const Value.absent(),
  })  : tagId = Value(tagId),
        temperature = Value(temperature),
        humidity = Value(humidity),
        materialResistivity = Value(materialResistivity);
  static Insertable<TagDataData> custom({
    Expression<int>? id,
    Expression<int>? tagId,
    Expression<double>? temperature,
    Expression<double>? humidity,
    Expression<double>? materialResistivity,
    Expression<DateTime>? measuredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tagId != null) 'tag_id': tagId,
      if (temperature != null) 'temperature': temperature,
      if (humidity != null) 'humidity': humidity,
      if (materialResistivity != null)
        'material_resistivity': materialResistivity,
      if (measuredAt != null) 'measured_at': measuredAt,
    });
  }

  TagDataCompanion copyWith(
      {Value<int>? id,
      Value<int>? tagId,
      Value<double>? temperature,
      Value<double>? humidity,
      Value<double>? materialResistivity,
      Value<DateTime>? measuredAt}) {
    return TagDataCompanion(
      id: id ?? this.id,
      tagId: tagId ?? this.tagId,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      materialResistivity: materialResistivity ?? this.materialResistivity,
      measuredAt: measuredAt ?? this.measuredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (temperature.present) {
      map['temperature'] = Variable<double>(temperature.value);
    }
    if (humidity.present) {
      map['humidity'] = Variable<double>(humidity.value);
    }
    if (materialResistivity.present) {
      map['material_resistivity'] = Variable<double>(materialResistivity.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagDataCompanion(')
          ..write('id: $id, ')
          ..write('tagId: $tagId, ')
          ..write('temperature: $temperature, ')
          ..write('humidity: $humidity, ')
          ..write('materialResistivity: $materialResistivity, ')
          ..write('measuredAt: $measuredAt')
          ..write(')'))
        .toString();
  }
}

class $MedicinesTable extends Medicines
    with TableInfo<$MedicinesTable, Medicine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<int> tagId = GeneratedColumn<int>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tags (id)'));
  static const VerificationMeta _refrigeratorIdMeta =
      const VerificationMeta('refrigeratorId');
  @override
  late final GeneratedColumn<int> refrigeratorId = GeneratedColumn<int>(
      'refrigerator_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES refrigerators (id)'));
  static const VerificationMeta _storageStatusMeta =
      const VerificationMeta('storageStatus');
  @override
  late final GeneratedColumn<String> storageStatus = GeneratedColumn<String>(
      'storage_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        tagId,
        refrigeratorId,
        storageStatus,
        quantity,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicines';
  @override
  VerificationContext validateIntegrity(Insertable<Medicine> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('refrigerator_id')) {
      context.handle(
          _refrigeratorIdMeta,
          refrigeratorId.isAcceptableOrUnknown(
              data['refrigerator_id']!, _refrigeratorIdMeta));
    } else if (isInserting) {
      context.missing(_refrigeratorIdMeta);
    }
    if (data.containsKey('storage_status')) {
      context.handle(
          _storageStatusMeta,
          storageStatus.isAcceptableOrUnknown(
              data['storage_status']!, _storageStatusMeta));
    } else if (isInserting) {
      context.missing(_storageStatusMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medicine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medicine(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tag_id'])!,
      refrigeratorId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}refrigerator_id'])!,
      storageStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_status'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $MedicinesTable createAlias(String alias) {
    return $MedicinesTable(attachedDatabase, alias);
  }
}

class Medicine extends DataClass implements Insertable<Medicine> {
  final int id;
  final String name;
  final int tagId;
  final int refrigeratorId;
  final String storageStatus;
  final int quantity;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Medicine(
      {required this.id,
      required this.name,
      required this.tagId,
      required this.refrigeratorId,
      required this.storageStatus,
      required this.quantity,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['tag_id'] = Variable<int>(tagId);
    map['refrigerator_id'] = Variable<int>(refrigeratorId);
    map['storage_status'] = Variable<String>(storageStatus);
    map['quantity'] = Variable<int>(quantity);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      id: Value(id),
      name: Value(name),
      tagId: Value(tagId),
      refrigeratorId: Value(refrigeratorId),
      storageStatus: Value(storageStatus),
      quantity: Value(quantity),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Medicine.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medicine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      tagId: serializer.fromJson<int>(json['tagId']),
      refrigeratorId: serializer.fromJson<int>(json['refrigeratorId']),
      storageStatus: serializer.fromJson<String>(json['storageStatus']),
      quantity: serializer.fromJson<int>(json['quantity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'tagId': serializer.toJson<int>(tagId),
      'refrigeratorId': serializer.toJson<int>(refrigeratorId),
      'storageStatus': serializer.toJson<String>(storageStatus),
      'quantity': serializer.toJson<int>(quantity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Medicine copyWith(
          {int? id,
          String? name,
          int? tagId,
          int? refrigeratorId,
          String? storageStatus,
          int? quantity,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Medicine(
        id: id ?? this.id,
        name: name ?? this.name,
        tagId: tagId ?? this.tagId,
        refrigeratorId: refrigeratorId ?? this.refrigeratorId,
        storageStatus: storageStatus ?? this.storageStatus,
        quantity: quantity ?? this.quantity,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Medicine copyWithCompanion(MedicinesCompanion data) {
    return Medicine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
      refrigeratorId: data.refrigeratorId.present
          ? data.refrigeratorId.value
          : this.refrigeratorId,
      storageStatus: data.storageStatus.present
          ? data.storageStatus.value
          : this.storageStatus,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medicine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tagId: $tagId, ')
          ..write('refrigeratorId: $refrigeratorId, ')
          ..write('storageStatus: $storageStatus, ')
          ..write('quantity: $quantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, tagId, refrigeratorId,
      storageStatus, quantity, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medicine &&
          other.id == this.id &&
          other.name == this.name &&
          other.tagId == this.tagId &&
          other.refrigeratorId == this.refrigeratorId &&
          other.storageStatus == this.storageStatus &&
          other.quantity == this.quantity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MedicinesCompanion extends UpdateCompanion<Medicine> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> tagId;
  final Value<int> refrigeratorId;
  final Value<String> storageStatus;
  final Value<int> quantity;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const MedicinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.tagId = const Value.absent(),
    this.refrigeratorId = const Value.absent(),
    this.storageStatus = const Value.absent(),
    this.quantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MedicinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int tagId,
    required int refrigeratorId,
    required String storageStatus,
    this.quantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : name = Value(name),
        tagId = Value(tagId),
        refrigeratorId = Value(refrigeratorId),
        storageStatus = Value(storageStatus);
  static Insertable<Medicine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? tagId,
    Expression<int>? refrigeratorId,
    Expression<String>? storageStatus,
    Expression<int>? quantity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (tagId != null) 'tag_id': tagId,
      if (refrigeratorId != null) 'refrigerator_id': refrigeratorId,
      if (storageStatus != null) 'storage_status': storageStatus,
      if (quantity != null) 'quantity': quantity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MedicinesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<int>? tagId,
      Value<int>? refrigeratorId,
      Value<String>? storageStatus,
      Value<int>? quantity,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return MedicinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      tagId: tagId ?? this.tagId,
      refrigeratorId: refrigeratorId ?? this.refrigeratorId,
      storageStatus: storageStatus ?? this.storageStatus,
      quantity: quantity ?? this.quantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<int>(tagId.value);
    }
    if (refrigeratorId.present) {
      map['refrigerator_id'] = Variable<int>(refrigeratorId.value);
    }
    if (storageStatus.present) {
      map['storage_status'] = Variable<String>(storageStatus.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('tagId: $tagId, ')
          ..write('refrigeratorId: $refrigeratorId, ')
          ..write('storageStatus: $storageStatus, ')
          ..write('quantity: $quantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MedicineDetailsTable extends MedicineDetails
    with TableInfo<$MedicineDetailsTable, MedicineDetail> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicineDetailsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _medicineIdMeta =
      const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
      'medicine_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'UNIQUE REFERENCES medicines (id)'));
  static const VerificationMeta _medicineNameMeta =
      const VerificationMeta('medicineName');
  @override
  late final GeneratedColumn<String> medicineName = GeneratedColumn<String>(
      'medicine_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 255),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _medicineTypeMeta =
      const VerificationMeta('medicineType');
  @override
  late final GeneratedColumn<String> medicineType = GeneratedColumn<String>(
      'medicine_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _manufacturerMeta =
      const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
      'manufacturer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _expirationDateMeta =
      const VerificationMeta('expirationDate');
  @override
  late final GeneratedColumn<DateTime> expirationDate =
      GeneratedColumn<DateTime>('expiration_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _storageDateMeta =
      const VerificationMeta('storageDate');
  @override
  late final GeneratedColumn<DateTime> storageDate = GeneratedColumn<DateTime>(
      'storage_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        medicineId,
        medicineName,
        medicineType,
        manufacturer,
        expirationDate,
        storageDate
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicine_details';
  @override
  VerificationContext validateIntegrity(Insertable<MedicineDetail> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('medicine_id')) {
      context.handle(
          _medicineIdMeta,
          medicineId.isAcceptableOrUnknown(
              data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('medicine_name')) {
      context.handle(
          _medicineNameMeta,
          medicineName.isAcceptableOrUnknown(
              data['medicine_name']!, _medicineNameMeta));
    } else if (isInserting) {
      context.missing(_medicineNameMeta);
    }
    if (data.containsKey('medicine_type')) {
      context.handle(
          _medicineTypeMeta,
          medicineType.isAcceptableOrUnknown(
              data['medicine_type']!, _medicineTypeMeta));
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
          _manufacturerMeta,
          manufacturer.isAcceptableOrUnknown(
              data['manufacturer']!, _manufacturerMeta));
    }
    if (data.containsKey('expiration_date')) {
      context.handle(
          _expirationDateMeta,
          expirationDate.isAcceptableOrUnknown(
              data['expiration_date']!, _expirationDateMeta));
    }
    if (data.containsKey('storage_date')) {
      context.handle(
          _storageDateMeta,
          storageDate.isAcceptableOrUnknown(
              data['storage_date']!, _storageDateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineDetail map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineDetail(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      medicineId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      medicineName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine_name'])!,
      medicineType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}medicine_type']),
      manufacturer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manufacturer']),
      expirationDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}expiration_date']),
      storageDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}storage_date'])!,
    );
  }

  @override
  $MedicineDetailsTable createAlias(String alias) {
    return $MedicineDetailsTable(attachedDatabase, alias);
  }
}

class MedicineDetail extends DataClass implements Insertable<MedicineDetail> {
  final int id;
  final int medicineId;
  final String medicineName;
  final String? medicineType;
  final String? manufacturer;
  final DateTime? expirationDate;
  final DateTime storageDate;
  const MedicineDetail(
      {required this.id,
      required this.medicineId,
      required this.medicineName,
      this.medicineType,
      this.manufacturer,
      this.expirationDate,
      required this.storageDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['medicine_id'] = Variable<int>(medicineId);
    map['medicine_name'] = Variable<String>(medicineName);
    if (!nullToAbsent || medicineType != null) {
      map['medicine_type'] = Variable<String>(medicineType);
    }
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || expirationDate != null) {
      map['expiration_date'] = Variable<DateTime>(expirationDate);
    }
    map['storage_date'] = Variable<DateTime>(storageDate);
    return map;
  }

  MedicineDetailsCompanion toCompanion(bool nullToAbsent) {
    return MedicineDetailsCompanion(
      id: Value(id),
      medicineId: Value(medicineId),
      medicineName: Value(medicineName),
      medicineType: medicineType == null && nullToAbsent
          ? const Value.absent()
          : Value(medicineType),
      manufacturer: manufacturer == null && nullToAbsent
          ? const Value.absent()
          : Value(manufacturer),
      expirationDate: expirationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expirationDate),
      storageDate: Value(storageDate),
    );
  }

  factory MedicineDetail.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineDetail(
      id: serializer.fromJson<int>(json['id']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      medicineName: serializer.fromJson<String>(json['medicineName']),
      medicineType: serializer.fromJson<String?>(json['medicineType']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      expirationDate: serializer.fromJson<DateTime?>(json['expirationDate']),
      storageDate: serializer.fromJson<DateTime>(json['storageDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'medicineId': serializer.toJson<int>(medicineId),
      'medicineName': serializer.toJson<String>(medicineName),
      'medicineType': serializer.toJson<String?>(medicineType),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'expirationDate': serializer.toJson<DateTime?>(expirationDate),
      'storageDate': serializer.toJson<DateTime>(storageDate),
    };
  }

  MedicineDetail copyWith(
          {int? id,
          int? medicineId,
          String? medicineName,
          Value<String?> medicineType = const Value.absent(),
          Value<String?> manufacturer = const Value.absent(),
          Value<DateTime?> expirationDate = const Value.absent(),
          DateTime? storageDate}) =>
      MedicineDetail(
        id: id ?? this.id,
        medicineId: medicineId ?? this.medicineId,
        medicineName: medicineName ?? this.medicineName,
        medicineType:
            medicineType.present ? medicineType.value : this.medicineType,
        manufacturer:
            manufacturer.present ? manufacturer.value : this.manufacturer,
        expirationDate:
            expirationDate.present ? expirationDate.value : this.expirationDate,
        storageDate: storageDate ?? this.storageDate,
      );
  MedicineDetail copyWithCompanion(MedicineDetailsCompanion data) {
    return MedicineDetail(
      id: data.id.present ? data.id.value : this.id,
      medicineId:
          data.medicineId.present ? data.medicineId.value : this.medicineId,
      medicineName: data.medicineName.present
          ? data.medicineName.value
          : this.medicineName,
      medicineType: data.medicineType.present
          ? data.medicineType.value
          : this.medicineType,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      expirationDate: data.expirationDate.present
          ? data.expirationDate.value
          : this.expirationDate,
      storageDate:
          data.storageDate.present ? data.storageDate.value : this.storageDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineDetail(')
          ..write('id: $id, ')
          ..write('medicineId: $medicineId, ')
          ..write('medicineName: $medicineName, ')
          ..write('medicineType: $medicineType, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('storageDate: $storageDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, medicineId, medicineName, medicineType,
      manufacturer, expirationDate, storageDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineDetail &&
          other.id == this.id &&
          other.medicineId == this.medicineId &&
          other.medicineName == this.medicineName &&
          other.medicineType == this.medicineType &&
          other.manufacturer == this.manufacturer &&
          other.expirationDate == this.expirationDate &&
          other.storageDate == this.storageDate);
}

class MedicineDetailsCompanion extends UpdateCompanion<MedicineDetail> {
  final Value<int> id;
  final Value<int> medicineId;
  final Value<String> medicineName;
  final Value<String?> medicineType;
  final Value<String?> manufacturer;
  final Value<DateTime?> expirationDate;
  final Value<DateTime> storageDate;
  const MedicineDetailsCompanion({
    this.id = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.medicineName = const Value.absent(),
    this.medicineType = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.storageDate = const Value.absent(),
  });
  MedicineDetailsCompanion.insert({
    this.id = const Value.absent(),
    required int medicineId,
    required String medicineName,
    this.medicineType = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.expirationDate = const Value.absent(),
    this.storageDate = const Value.absent(),
  })  : medicineId = Value(medicineId),
        medicineName = Value(medicineName);
  static Insertable<MedicineDetail> custom({
    Expression<int>? id,
    Expression<int>? medicineId,
    Expression<String>? medicineName,
    Expression<String>? medicineType,
    Expression<String>? manufacturer,
    Expression<DateTime>? expirationDate,
    Expression<DateTime>? storageDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicineId != null) 'medicine_id': medicineId,
      if (medicineName != null) 'medicine_name': medicineName,
      if (medicineType != null) 'medicine_type': medicineType,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (expirationDate != null) 'expiration_date': expirationDate,
      if (storageDate != null) 'storage_date': storageDate,
    });
  }

  MedicineDetailsCompanion copyWith(
      {Value<int>? id,
      Value<int>? medicineId,
      Value<String>? medicineName,
      Value<String?>? medicineType,
      Value<String?>? manufacturer,
      Value<DateTime?>? expirationDate,
      Value<DateTime>? storageDate}) {
    return MedicineDetailsCompanion(
      id: id ?? this.id,
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      medicineType: medicineType ?? this.medicineType,
      manufacturer: manufacturer ?? this.manufacturer,
      expirationDate: expirationDate ?? this.expirationDate,
      storageDate: storageDate ?? this.storageDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (medicineName.present) {
      map['medicine_name'] = Variable<String>(medicineName.value);
    }
    if (medicineType.present) {
      map['medicine_type'] = Variable<String>(medicineType.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (expirationDate.present) {
      map['expiration_date'] = Variable<DateTime>(expirationDate.value);
    }
    if (storageDate.present) {
      map['storage_date'] = Variable<DateTime>(storageDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicineDetailsCompanion(')
          ..write('id: $id, ')
          ..write('medicineId: $medicineId, ')
          ..write('medicineName: $medicineName, ')
          ..write('medicineType: $medicineType, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('expirationDate: $expirationDate, ')
          ..write('storageDate: $storageDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RefrigeratorsTable refrigerators = $RefrigeratorsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $TagDataTable tagData = $TagDataTable(this);
  late final $MedicinesTable medicines = $MedicinesTable(this);
  late final $MedicineDetailsTable medicineDetails =
      $MedicineDetailsTable(this);
  late final TagDao tagDao = TagDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [refrigerators, tags, tagData, medicines, medicineDetails];
}

typedef $$RefrigeratorsTableCreateCompanionBuilder = RefrigeratorsCompanion
    Function({
  Value<int> id,
  required String name,
  required String location,
});
typedef $$RefrigeratorsTableUpdateCompanionBuilder = RefrigeratorsCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> location,
});

final class $$RefrigeratorsTableReferences
    extends BaseReferences<_$AppDatabase, $RefrigeratorsTable, Refrigerator> {
  $$RefrigeratorsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TagsTable, List<Tag>> _tagsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.tags,
          aliasName: $_aliasNameGenerator(
              db.refrigerators.id, db.tags.refrigeratorId));

  $$TagsTableProcessedTableManager get tagsRefs {
    final manager = $$TagsTableTableManager($_db, $_db.tags)
        .filter((f) => f.refrigeratorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tagsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MedicinesTable, List<Medicine>>
      _medicinesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.medicines,
              aliasName: $_aliasNameGenerator(
                  db.refrigerators.id, db.medicines.refrigeratorId));

  $$MedicinesTableProcessedTableManager get medicinesRefs {
    final manager = $$MedicinesTableTableManager($_db, $_db.medicines)
        .filter((f) => f.refrigeratorId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_medicinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RefrigeratorsTableFilterComposer
    extends Composer<_$AppDatabase, $RefrigeratorsTable> {
  $$RefrigeratorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  Expression<bool> tagsRefs(
      Expression<bool> Function($$TagsTableFilterComposer f) f) {
    final $$TagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.refrigeratorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableFilterComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> medicinesRefs(
      Expression<bool> Function($$MedicinesTableFilterComposer f) f) {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.refrigeratorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableFilterComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RefrigeratorsTableOrderingComposer
    extends Composer<_$AppDatabase, $RefrigeratorsTable> {
  $$RefrigeratorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));
}

class $$RefrigeratorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RefrigeratorsTable> {
  $$RefrigeratorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  Expression<T> tagsRefs<T extends Object>(
      Expression<T> Function($$TagsTableAnnotationComposer a) f) {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.refrigeratorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableAnnotationComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> medicinesRefs<T extends Object>(
      Expression<T> Function($$MedicinesTableAnnotationComposer a) f) {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.refrigeratorId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableAnnotationComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RefrigeratorsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RefrigeratorsTable,
    Refrigerator,
    $$RefrigeratorsTableFilterComposer,
    $$RefrigeratorsTableOrderingComposer,
    $$RefrigeratorsTableAnnotationComposer,
    $$RefrigeratorsTableCreateCompanionBuilder,
    $$RefrigeratorsTableUpdateCompanionBuilder,
    (Refrigerator, $$RefrigeratorsTableReferences),
    Refrigerator,
    PrefetchHooks Function({bool tagsRefs, bool medicinesRefs})> {
  $$RefrigeratorsTableTableManager(_$AppDatabase db, $RefrigeratorsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RefrigeratorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RefrigeratorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RefrigeratorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> location = const Value.absent(),
          }) =>
              RefrigeratorsCompanion(
            id: id,
            name: name,
            location: location,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String location,
          }) =>
              RefrigeratorsCompanion.insert(
            id: id,
            name: name,
            location: location,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$RefrigeratorsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({tagsRefs = false, medicinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tagsRefs) db.tags,
                if (medicinesRefs) db.medicines
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tagsRefs)
                    await $_getPrefetchedData<Refrigerator, $RefrigeratorsTable,
                            Tag>(
                        currentTable: table,
                        referencedTable:
                            $$RefrigeratorsTableReferences._tagsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RefrigeratorsTableReferences(db, table, p0)
                                .tagsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.refrigeratorId == item.id),
                        typedResults: items),
                  if (medicinesRefs)
                    await $_getPrefetchedData<Refrigerator, $RefrigeratorsTable,
                            Medicine>(
                        currentTable: table,
                        referencedTable: $$RefrigeratorsTableReferences
                            ._medicinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RefrigeratorsTableReferences(db, table, p0)
                                .medicinesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.refrigeratorId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RefrigeratorsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RefrigeratorsTable,
    Refrigerator,
    $$RefrigeratorsTableFilterComposer,
    $$RefrigeratorsTableOrderingComposer,
    $$RefrigeratorsTableAnnotationComposer,
    $$RefrigeratorsTableCreateCompanionBuilder,
    $$RefrigeratorsTableUpdateCompanionBuilder,
    (Refrigerator, $$RefrigeratorsTableReferences),
    Refrigerator,
    PrefetchHooks Function({bool tagsRefs, bool medicinesRefs})>;
typedef $$TagsTableCreateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  required String uid,
  Value<String?> deviceAddress,
  required String name,
  required String sensorPeriod,
  Value<DateTime?> lastUpdate,
  Value<int?> refrigeratorId,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<int> id,
  Value<String> uid,
  Value<String?> deviceAddress,
  Value<String> name,
  Value<String> sensorPeriod,
  Value<DateTime?> lastUpdate,
  Value<int?> refrigeratorId,
});

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RefrigeratorsTable _refrigeratorIdTable(_$AppDatabase db) =>
      db.refrigerators.createAlias(
          $_aliasNameGenerator(db.tags.refrigeratorId, db.refrigerators.id));

  $$RefrigeratorsTableProcessedTableManager? get refrigeratorId {
    final $_column = $_itemColumn<int>('refrigerator_id');
    if ($_column == null) return null;
    final manager = $$RefrigeratorsTableTableManager($_db, $_db.refrigerators)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_refrigeratorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TagDataTable, List<TagDataData>>
      _tagDataRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.tagData,
              aliasName: $_aliasNameGenerator(db.tags.id, db.tagData.tagId));

  $$TagDataTableProcessedTableManager get tagDataRefs {
    final manager = $$TagDataTableTableManager($_db, $_db.tagData)
        .filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tagDataRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$MedicinesTable, List<Medicine>>
      _medicinesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.medicines,
              aliasName: $_aliasNameGenerator(db.tags.id, db.medicines.tagId));

  $$MedicinesTableProcessedTableManager get medicinesRefs {
    final manager = $$MedicinesTableTableManager($_db, $_db.medicines)
        .filter((f) => f.tagId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_medicinesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sensorPeriod => $composableBuilder(
      column: $table.sensorPeriod, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnFilters(column));

  $$RefrigeratorsTableFilterComposer get refrigeratorId {
    final $$RefrigeratorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.refrigeratorId,
        referencedTable: $db.refrigerators,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RefrigeratorsTableFilterComposer(
              $db: $db,
              $table: $db.refrigerators,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> tagDataRefs(
      Expression<bool> Function($$TagDataTableFilterComposer f) f) {
    final $$TagDataTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tagData,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagDataTableFilterComposer(
              $db: $db,
              $table: $db.tagData,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> medicinesRefs(
      Expression<bool> Function($$MedicinesTableFilterComposer f) f) {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableFilterComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sensorPeriod => $composableBuilder(
      column: $table.sensorPeriod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnOrderings(column));

  $$RefrigeratorsTableOrderingComposer get refrigeratorId {
    final $$RefrigeratorsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.refrigeratorId,
        referencedTable: $db.refrigerators,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RefrigeratorsTableOrderingComposer(
              $db: $db,
              $table: $db.refrigerators,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get deviceAddress => $composableBuilder(
      column: $table.deviceAddress, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get sensorPeriod => $composableBuilder(
      column: $table.sensorPeriod, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => column);

  $$RefrigeratorsTableAnnotationComposer get refrigeratorId {
    final $$RefrigeratorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.refrigeratorId,
        referencedTable: $db.refrigerators,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RefrigeratorsTableAnnotationComposer(
              $db: $db,
              $table: $db.refrigerators,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> tagDataRefs<T extends Object>(
      Expression<T> Function($$TagDataTableAnnotationComposer a) f) {
    final $$TagDataTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tagData,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagDataTableAnnotationComposer(
              $db: $db,
              $table: $db.tagData,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> medicinesRefs<T extends Object>(
      Expression<T> Function($$MedicinesTableAnnotationComposer a) f) {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.tagId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableAnnotationComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, $$TagsTableReferences),
    Tag,
    PrefetchHooks Function(
        {bool refrigeratorId, bool tagDataRefs, bool medicinesRefs})> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<String?> deviceAddress = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> sensorPeriod = const Value.absent(),
            Value<DateTime?> lastUpdate = const Value.absent(),
            Value<int?> refrigeratorId = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            uid: uid,
            deviceAddress: deviceAddress,
            name: name,
            sensorPeriod: sensorPeriod,
            lastUpdate: lastUpdate,
            refrigeratorId: refrigeratorId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String uid,
            Value<String?> deviceAddress = const Value.absent(),
            required String name,
            required String sensorPeriod,
            Value<DateTime?> lastUpdate = const Value.absent(),
            Value<int?> refrigeratorId = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            uid: uid,
            deviceAddress: deviceAddress,
            name: name,
            sensorPeriod: sensorPeriod,
            lastUpdate: lastUpdate,
            refrigeratorId: refrigeratorId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TagsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {refrigeratorId = false,
              tagDataRefs = false,
              medicinesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (tagDataRefs) db.tagData,
                if (medicinesRefs) db.medicines
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (refrigeratorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.refrigeratorId,
                    referencedTable:
                        $$TagsTableReferences._refrigeratorIdTable(db),
                    referencedColumn:
                        $$TagsTableReferences._refrigeratorIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tagDataRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, TagDataData>(
                        currentTable: table,
                        referencedTable:
                            $$TagsTableReferences._tagDataRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagsTableReferences(db, table, p0).tagDataRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tagId == item.id),
                        typedResults: items),
                  if (medicinesRefs)
                    await $_getPrefetchedData<Tag, $TagsTable, Medicine>(
                        currentTable: table,
                        referencedTable:
                            $$TagsTableReferences._medicinesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TagsTableReferences(db, table, p0).medicinesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.tagId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TagsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableAnnotationComposer,
    $$TagsTableCreateCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder,
    (Tag, $$TagsTableReferences),
    Tag,
    PrefetchHooks Function(
        {bool refrigeratorId, bool tagDataRefs, bool medicinesRefs})>;
typedef $$TagDataTableCreateCompanionBuilder = TagDataCompanion Function({
  Value<int> id,
  required int tagId,
  required double temperature,
  required double humidity,
  required double materialResistivity,
  Value<DateTime> measuredAt,
});
typedef $$TagDataTableUpdateCompanionBuilder = TagDataCompanion Function({
  Value<int> id,
  Value<int> tagId,
  Value<double> temperature,
  Value<double> humidity,
  Value<double> materialResistivity,
  Value<DateTime> measuredAt,
});

final class $$TagDataTableReferences
    extends BaseReferences<_$AppDatabase, $TagDataTable, TagDataData> {
  $$TagDataTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.tagData.tagId, db.tags.id));

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager($_db, $_db.tags)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TagDataTableFilterComposer
    extends Composer<_$AppDatabase, $TagDataTable> {
  $$TagDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get humidity => $composableBuilder(
      column: $table.humidity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get materialResistivity => $composableBuilder(
      column: $table.materialResistivity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableFilterComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TagDataTableOrderingComposer
    extends Composer<_$AppDatabase, $TagDataTable> {
  $$TagDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get humidity => $composableBuilder(
      column: $table.humidity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get materialResistivity => $composableBuilder(
      column: $table.materialResistivity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableOrderingComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TagDataTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagDataTable> {
  $$TagDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get temperature => $composableBuilder(
      column: $table.temperature, builder: (column) => column);

  GeneratedColumn<double> get humidity =>
      $composableBuilder(column: $table.humidity, builder: (column) => column);

  GeneratedColumn<double> get materialResistivity => $composableBuilder(
      column: $table.materialResistivity, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableAnnotationComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TagDataTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagDataTable,
    TagDataData,
    $$TagDataTableFilterComposer,
    $$TagDataTableOrderingComposer,
    $$TagDataTableAnnotationComposer,
    $$TagDataTableCreateCompanionBuilder,
    $$TagDataTableUpdateCompanionBuilder,
    (TagDataData, $$TagDataTableReferences),
    TagDataData,
    PrefetchHooks Function({bool tagId})> {
  $$TagDataTableTableManager(_$AppDatabase db, $TagDataTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<double> temperature = const Value.absent(),
            Value<double> humidity = const Value.absent(),
            Value<double> materialResistivity = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
          }) =>
              TagDataCompanion(
            id: id,
            tagId: tagId,
            temperature: temperature,
            humidity: humidity,
            materialResistivity: materialResistivity,
            measuredAt: measuredAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int tagId,
            required double temperature,
            required double humidity,
            required double materialResistivity,
            Value<DateTime> measuredAt = const Value.absent(),
          }) =>
              TagDataCompanion.insert(
            id: id,
            tagId: tagId,
            temperature: temperature,
            humidity: humidity,
            materialResistivity: materialResistivity,
            measuredAt: measuredAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TagDataTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({tagId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (tagId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable: $$TagDataTableReferences._tagIdTable(db),
                    referencedColumn:
                        $$TagDataTableReferences._tagIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TagDataTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TagDataTable,
    TagDataData,
    $$TagDataTableFilterComposer,
    $$TagDataTableOrderingComposer,
    $$TagDataTableAnnotationComposer,
    $$TagDataTableCreateCompanionBuilder,
    $$TagDataTableUpdateCompanionBuilder,
    (TagDataData, $$TagDataTableReferences),
    TagDataData,
    PrefetchHooks Function({bool tagId})>;
typedef $$MedicinesTableCreateCompanionBuilder = MedicinesCompanion Function({
  Value<int> id,
  required String name,
  required int tagId,
  required int refrigeratorId,
  required String storageStatus,
  Value<int> quantity,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$MedicinesTableUpdateCompanionBuilder = MedicinesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<int> tagId,
  Value<int> refrigeratorId,
  Value<String> storageStatus,
  Value<int> quantity,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

final class $$MedicinesTableReferences
    extends BaseReferences<_$AppDatabase, $MedicinesTable, Medicine> {
  $$MedicinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.medicines.tagId, db.tags.id));

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<int>('tag_id')!;

    final manager = $$TagsTableTableManager($_db, $_db.tags)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RefrigeratorsTable _refrigeratorIdTable(_$AppDatabase db) =>
      db.refrigerators.createAlias($_aliasNameGenerator(
          db.medicines.refrigeratorId, db.refrigerators.id));

  $$RefrigeratorsTableProcessedTableManager get refrigeratorId {
    final $_column = $_itemColumn<int>('refrigerator_id')!;

    final manager = $$RefrigeratorsTableTableManager($_db, $_db.refrigerators)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_refrigeratorIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$MedicineDetailsTable, List<MedicineDetail>>
      _medicineDetailsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.medicineDetails,
              aliasName: $_aliasNameGenerator(
                  db.medicines.id, db.medicineDetails.medicineId));

  $$MedicineDetailsTableProcessedTableManager get medicineDetailsRefs {
    final manager =
        $$MedicineDetailsTableTableManager($_db, $_db.medicineDetails)
            .filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_medicineDetailsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MedicinesTableFilterComposer
    extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get storageStatus => $composableBuilder(
      column: $table.storageStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableFilterComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RefrigeratorsTableFilterComposer get refrigeratorId {
    final $$RefrigeratorsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.refrigeratorId,
        referencedTable: $db.refrigerators,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RefrigeratorsTableFilterComposer(
              $db: $db,
              $table: $db.refrigerators,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> medicineDetailsRefs(
      Expression<bool> Function($$MedicineDetailsTableFilterComposer f) f) {
    final $$MedicineDetailsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicineDetails,
        getReferencedColumn: (t) => t.medicineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicineDetailsTableFilterComposer(
              $db: $db,
              $table: $db.medicineDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MedicinesTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storageStatus => $composableBuilder(
      column: $table.storageStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableOrderingComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RefrigeratorsTableOrderingComposer get refrigeratorId {
    final $$RefrigeratorsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.refrigeratorId,
        referencedTable: $db.refrigerators,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RefrigeratorsTableOrderingComposer(
              $db: $db,
              $table: $db.refrigerators,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get storageStatus => $composableBuilder(
      column: $table.storageStatus, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tagId,
        referencedTable: $db.tags,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TagsTableAnnotationComposer(
              $db: $db,
              $table: $db.tags,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RefrigeratorsTableAnnotationComposer get refrigeratorId {
    final $$RefrigeratorsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.refrigeratorId,
        referencedTable: $db.refrigerators,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RefrigeratorsTableAnnotationComposer(
              $db: $db,
              $table: $db.refrigerators,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> medicineDetailsRefs<T extends Object>(
      Expression<T> Function($$MedicineDetailsTableAnnotationComposer a) f) {
    final $$MedicineDetailsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.medicineDetails,
        getReferencedColumn: (t) => t.medicineId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicineDetailsTableAnnotationComposer(
              $db: $db,
              $table: $db.medicineDetails,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MedicinesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicinesTable,
    Medicine,
    $$MedicinesTableFilterComposer,
    $$MedicinesTableOrderingComposer,
    $$MedicinesTableAnnotationComposer,
    $$MedicinesTableCreateCompanionBuilder,
    $$MedicinesTableUpdateCompanionBuilder,
    (Medicine, $$MedicinesTableReferences),
    Medicine,
    PrefetchHooks Function(
        {bool tagId, bool refrigeratorId, bool medicineDetailsRefs})> {
  $$MedicinesTableTableManager(_$AppDatabase db, $MedicinesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> tagId = const Value.absent(),
            Value<int> refrigeratorId = const Value.absent(),
            Value<String> storageStatus = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              MedicinesCompanion(
            id: id,
            name: name,
            tagId: tagId,
            refrigeratorId: refrigeratorId,
            storageStatus: storageStatus,
            quantity: quantity,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required int tagId,
            required int refrigeratorId,
            required String storageStatus,
            Value<int> quantity = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              MedicinesCompanion.insert(
            id: id,
            name: name,
            tagId: tagId,
            refrigeratorId: refrigeratorId,
            storageStatus: storageStatus,
            quantity: quantity,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicinesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {tagId = false,
              refrigeratorId = false,
              medicineDetailsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (medicineDetailsRefs) db.medicineDetails
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (tagId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tagId,
                    referencedTable: $$MedicinesTableReferences._tagIdTable(db),
                    referencedColumn:
                        $$MedicinesTableReferences._tagIdTable(db).id,
                  ) as T;
                }
                if (refrigeratorId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.refrigeratorId,
                    referencedTable:
                        $$MedicinesTableReferences._refrigeratorIdTable(db),
                    referencedColumn:
                        $$MedicinesTableReferences._refrigeratorIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (medicineDetailsRefs)
                    await $_getPrefetchedData<Medicine, $MedicinesTable,
                            MedicineDetail>(
                        currentTable: table,
                        referencedTable: $$MedicinesTableReferences
                            ._medicineDetailsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MedicinesTableReferences(db, table, p0)
                                .medicineDetailsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.medicineId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MedicinesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicinesTable,
    Medicine,
    $$MedicinesTableFilterComposer,
    $$MedicinesTableOrderingComposer,
    $$MedicinesTableAnnotationComposer,
    $$MedicinesTableCreateCompanionBuilder,
    $$MedicinesTableUpdateCompanionBuilder,
    (Medicine, $$MedicinesTableReferences),
    Medicine,
    PrefetchHooks Function(
        {bool tagId, bool refrigeratorId, bool medicineDetailsRefs})>;
typedef $$MedicineDetailsTableCreateCompanionBuilder = MedicineDetailsCompanion
    Function({
  Value<int> id,
  required int medicineId,
  required String medicineName,
  Value<String?> medicineType,
  Value<String?> manufacturer,
  Value<DateTime?> expirationDate,
  Value<DateTime> storageDate,
});
typedef $$MedicineDetailsTableUpdateCompanionBuilder = MedicineDetailsCompanion
    Function({
  Value<int> id,
  Value<int> medicineId,
  Value<String> medicineName,
  Value<String?> medicineType,
  Value<String?> manufacturer,
  Value<DateTime?> expirationDate,
  Value<DateTime> storageDate,
});

final class $$MedicineDetailsTableReferences extends BaseReferences<
    _$AppDatabase, $MedicineDetailsTable, MedicineDetail> {
  $$MedicineDetailsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias(
          $_aliasNameGenerator(db.medicineDetails.medicineId, db.medicines.id));

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MedicineDetailsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicineDetailsTable> {
  $$MedicineDetailsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicineType => $composableBuilder(
      column: $table.medicineType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expirationDate => $composableBuilder(
      column: $table.expirationDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get storageDate => $composableBuilder(
      column: $table.storageDate, builder: (column) => ColumnFilters(column));

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.medicineId,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableFilterComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicineDetailsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicineDetailsTable> {
  $$MedicineDetailsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicineName => $composableBuilder(
      column: $table.medicineName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicineType => $composableBuilder(
      column: $table.medicineType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expirationDate => $composableBuilder(
      column: $table.expirationDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get storageDate => $composableBuilder(
      column: $table.storageDate, builder: (column) => ColumnOrderings(column));

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.medicineId,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableOrderingComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicineDetailsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicineDetailsTable> {
  $$MedicineDetailsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicineName => $composableBuilder(
      column: $table.medicineName, builder: (column) => column);

  GeneratedColumn<String> get medicineType => $composableBuilder(
      column: $table.medicineType, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
      column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<DateTime> get expirationDate => $composableBuilder(
      column: $table.expirationDate, builder: (column) => column);

  GeneratedColumn<DateTime> get storageDate => $composableBuilder(
      column: $table.storageDate, builder: (column) => column);

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.medicineId,
        referencedTable: $db.medicines,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MedicinesTableAnnotationComposer(
              $db: $db,
              $table: $db.medicines,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MedicineDetailsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MedicineDetailsTable,
    MedicineDetail,
    $$MedicineDetailsTableFilterComposer,
    $$MedicineDetailsTableOrderingComposer,
    $$MedicineDetailsTableAnnotationComposer,
    $$MedicineDetailsTableCreateCompanionBuilder,
    $$MedicineDetailsTableUpdateCompanionBuilder,
    (MedicineDetail, $$MedicineDetailsTableReferences),
    MedicineDetail,
    PrefetchHooks Function({bool medicineId})> {
  $$MedicineDetailsTableTableManager(
      _$AppDatabase db, $MedicineDetailsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicineDetailsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicineDetailsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicineDetailsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> medicineId = const Value.absent(),
            Value<String> medicineName = const Value.absent(),
            Value<String?> medicineType = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<DateTime?> expirationDate = const Value.absent(),
            Value<DateTime> storageDate = const Value.absent(),
          }) =>
              MedicineDetailsCompanion(
            id: id,
            medicineId: medicineId,
            medicineName: medicineName,
            medicineType: medicineType,
            manufacturer: manufacturer,
            expirationDate: expirationDate,
            storageDate: storageDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int medicineId,
            required String medicineName,
            Value<String?> medicineType = const Value.absent(),
            Value<String?> manufacturer = const Value.absent(),
            Value<DateTime?> expirationDate = const Value.absent(),
            Value<DateTime> storageDate = const Value.absent(),
          }) =>
              MedicineDetailsCompanion.insert(
            id: id,
            medicineId: medicineId,
            medicineName: medicineName,
            medicineType: medicineType,
            manufacturer: manufacturer,
            expirationDate: expirationDate,
            storageDate: storageDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MedicineDetailsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({medicineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (medicineId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.medicineId,
                    referencedTable:
                        $$MedicineDetailsTableReferences._medicineIdTable(db),
                    referencedColumn: $$MedicineDetailsTableReferences
                        ._medicineIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MedicineDetailsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MedicineDetailsTable,
    MedicineDetail,
    $$MedicineDetailsTableFilterComposer,
    $$MedicineDetailsTableOrderingComposer,
    $$MedicineDetailsTableAnnotationComposer,
    $$MedicineDetailsTableCreateCompanionBuilder,
    $$MedicineDetailsTableUpdateCompanionBuilder,
    (MedicineDetail, $$MedicineDetailsTableReferences),
    MedicineDetail,
    PrefetchHooks Function({bool medicineId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RefrigeratorsTableTableManager get refrigerators =>
      $$RefrigeratorsTableTableManager(_db, _db.refrigerators);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$TagDataTableTableManager get tagData =>
      $$TagDataTableTableManager(_db, _db.tagData);
  $$MedicinesTableTableManager get medicines =>
      $$MedicinesTableTableManager(_db, _db.medicines);
  $$MedicineDetailsTableTableManager get medicineDetails =>
      $$MedicineDetailsTableTableManager(_db, _db.medicineDetails);
}
