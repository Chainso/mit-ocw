// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PlaylistTable extends Playlist
    with TableInfo<$PlaylistTable, PlaylistData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistTable(this.attachedDatabase, [this._alias]);
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
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistData> instance,
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
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {name},
      ];
  @override
  PlaylistData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PlaylistTable createAlias(String alias) {
    return $PlaylistTable(attachedDatabase, alias);
  }
}

class PlaylistData extends DataClass implements Insertable<PlaylistData> {
  final int id;
  final String name;
  final DateTime createdAt;
  const PlaylistData(
      {required this.id, required this.name, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlaylistCompanion toCompanion(bool nullToAbsent) {
    return PlaylistCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory PlaylistData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlaylistData copyWith({int? id, String? name, DateTime? createdAt}) =>
      PlaylistData(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
      );
  PlaylistData copyWithCompanion(PlaylistCompanion data) {
    return PlaylistData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class PlaylistCompanion extends UpdateCompanion<PlaylistData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const PlaylistCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlaylistCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<PlaylistData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlaylistCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<DateTime>? createdAt}) {
    return PlaylistCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
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
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PlaylistCourseTable extends PlaylistCourse
    with TableInfo<$PlaylistCourseTable, PlaylistCourseData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistCourseTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES playlist (id)'));
  static const VerificationMeta _coursenumMeta =
      const VerificationMeta('coursenum');
  @override
  late final GeneratedColumn<String> coursenum = GeneratedColumn<String>(
      'coursenum', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [playlistId, coursenum, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_course';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistCourseData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('coursenum')) {
      context.handle(_coursenumMeta,
          coursenum.isAcceptableOrUnknown(data['coursenum']!, _coursenumMeta));
    } else if (isInserting) {
      context.missing(_coursenumMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playlistId, coursenum};
  @override
  PlaylistCourseData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistCourseData(
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}playlist_id'])!,
      coursenum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coursenum'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PlaylistCourseTable createAlias(String alias) {
    return $PlaylistCourseTable(attachedDatabase, alias);
  }
}

class PlaylistCourseData extends DataClass
    implements Insertable<PlaylistCourseData> {
  final int playlistId;
  final String coursenum;
  final DateTime createdAt;
  const PlaylistCourseData(
      {required this.playlistId,
      required this.coursenum,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['playlist_id'] = Variable<int>(playlistId);
    map['coursenum'] = Variable<String>(coursenum);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlaylistCourseCompanion toCompanion(bool nullToAbsent) {
    return PlaylistCourseCompanion(
      playlistId: Value(playlistId),
      coursenum: Value(coursenum),
      createdAt: Value(createdAt),
    );
  }

  factory PlaylistCourseData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistCourseData(
      playlistId: serializer.fromJson<int>(json['playlistId']),
      coursenum: serializer.fromJson<String>(json['coursenum']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playlistId': serializer.toJson<int>(playlistId),
      'coursenum': serializer.toJson<String>(coursenum),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlaylistCourseData copyWith(
          {int? playlistId, String? coursenum, DateTime? createdAt}) =>
      PlaylistCourseData(
        playlistId: playlistId ?? this.playlistId,
        coursenum: coursenum ?? this.coursenum,
        createdAt: createdAt ?? this.createdAt,
      );
  PlaylistCourseData copyWithCompanion(PlaylistCourseCompanion data) {
    return PlaylistCourseData(
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      coursenum: data.coursenum.present ? data.coursenum.value : this.coursenum,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistCourseData(')
          ..write('playlistId: $playlistId, ')
          ..write('coursenum: $coursenum, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(playlistId, coursenum, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistCourseData &&
          other.playlistId == this.playlistId &&
          other.coursenum == this.coursenum &&
          other.createdAt == this.createdAt);
}

class PlaylistCourseCompanion extends UpdateCompanion<PlaylistCourseData> {
  final Value<int> playlistId;
  final Value<String> coursenum;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PlaylistCourseCompanion({
    this.playlistId = const Value.absent(),
    this.coursenum = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaylistCourseCompanion.insert({
    required int playlistId,
    required String coursenum,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : playlistId = Value(playlistId),
        coursenum = Value(coursenum);
  static Insertable<PlaylistCourseData> custom({
    Expression<int>? playlistId,
    Expression<String>? coursenum,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playlistId != null) 'playlist_id': playlistId,
      if (coursenum != null) 'coursenum': coursenum,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaylistCourseCompanion copyWith(
      {Value<int>? playlistId,
      Value<String>? coursenum,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return PlaylistCourseCompanion(
      playlistId: playlistId ?? this.playlistId,
      coursenum: coursenum ?? this.coursenum,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (coursenum.present) {
      map['coursenum'] = Variable<String>(coursenum.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistCourseCompanion(')
          ..write('playlistId: $playlistId, ')
          ..write('coursenum: $coursenum, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoursePreferencesTable extends CoursePreferences
    with TableInfo<$CoursePreferencesTable, CoursePreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoursePreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coursenumMeta =
      const VerificationMeta('coursenum');
  @override
  late final GeneratedColumn<String> coursenum = GeneratedColumn<String>(
      'coursenum', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _showInContinueWatchingMeta =
      const VerificationMeta('showInContinueWatching');
  @override
  late final GeneratedColumn<bool> showInContinueWatching =
      GeneratedColumn<bool>('show_in_continue_watching', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("show_in_continue_watching" IN (0, 1))'),
          defaultValue: const Constant(true));
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
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [coursenum, showInContinueWatching, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'course_preferences';
  @override
  VerificationContext validateIntegrity(Insertable<CoursePreference> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('coursenum')) {
      context.handle(_coursenumMeta,
          coursenum.isAcceptableOrUnknown(data['coursenum']!, _coursenumMeta));
    } else if (isInserting) {
      context.missing(_coursenumMeta);
    }
    if (data.containsKey('show_in_continue_watching')) {
      context.handle(
          _showInContinueWatchingMeta,
          showInContinueWatching.isAcceptableOrUnknown(
              data['show_in_continue_watching']!, _showInContinueWatchingMeta));
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
  Set<GeneratedColumn> get $primaryKey => {coursenum};
  @override
  CoursePreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoursePreference(
      coursenum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coursenum'])!,
      showInContinueWatching: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}show_in_continue_watching'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $CoursePreferencesTable createAlias(String alias) {
    return $CoursePreferencesTable(attachedDatabase, alias);
  }
}

class CoursePreference extends DataClass
    implements Insertable<CoursePreference> {
  final String coursenum;
  final bool showInContinueWatching;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CoursePreference(
      {required this.coursenum,
      required this.showInContinueWatching,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['coursenum'] = Variable<String>(coursenum);
    map['show_in_continue_watching'] = Variable<bool>(showInContinueWatching);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CoursePreferencesCompanion toCompanion(bool nullToAbsent) {
    return CoursePreferencesCompanion(
      coursenum: Value(coursenum),
      showInContinueWatching: Value(showInContinueWatching),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CoursePreference.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoursePreference(
      coursenum: serializer.fromJson<String>(json['coursenum']),
      showInContinueWatching:
          serializer.fromJson<bool>(json['showInContinueWatching']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coursenum': serializer.toJson<String>(coursenum),
      'showInContinueWatching': serializer.toJson<bool>(showInContinueWatching),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CoursePreference copyWith(
          {String? coursenum,
          bool? showInContinueWatching,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      CoursePreference(
        coursenum: coursenum ?? this.coursenum,
        showInContinueWatching:
            showInContinueWatching ?? this.showInContinueWatching,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CoursePreference copyWithCompanion(CoursePreferencesCompanion data) {
    return CoursePreference(
      coursenum: data.coursenum.present ? data.coursenum.value : this.coursenum,
      showInContinueWatching: data.showInContinueWatching.present
          ? data.showInContinueWatching.value
          : this.showInContinueWatching,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoursePreference(')
          ..write('coursenum: $coursenum, ')
          ..write('showInContinueWatching: $showInContinueWatching, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(coursenum, showInContinueWatching, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoursePreference &&
          other.coursenum == this.coursenum &&
          other.showInContinueWatching == this.showInContinueWatching &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CoursePreferencesCompanion extends UpdateCompanion<CoursePreference> {
  final Value<String> coursenum;
  final Value<bool> showInContinueWatching;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CoursePreferencesCompanion({
    this.coursenum = const Value.absent(),
    this.showInContinueWatching = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoursePreferencesCompanion.insert({
    required String coursenum,
    this.showInContinueWatching = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : coursenum = Value(coursenum);
  static Insertable<CoursePreference> custom({
    Expression<String>? coursenum,
    Expression<bool>? showInContinueWatching,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coursenum != null) 'coursenum': coursenum,
      if (showInContinueWatching != null)
        'show_in_continue_watching': showInContinueWatching,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoursePreferencesCompanion copyWith(
      {Value<String>? coursenum,
      Value<bool>? showInContinueWatching,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return CoursePreferencesCompanion(
      coursenum: coursenum ?? this.coursenum,
      showInContinueWatching:
          showInContinueWatching ?? this.showInContinueWatching,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coursenum.present) {
      map['coursenum'] = Variable<String>(coursenum.value);
    }
    if (showInContinueWatching.present) {
      map['show_in_continue_watching'] =
          Variable<bool>(showInContinueWatching.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoursePreferencesCompanion(')
          ..write('coursenum: $coursenum, ')
          ..write('showInContinueWatching: $showInContinueWatching, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LectureWatchHistoryTable extends LectureWatchHistory
    with TableInfo<$LectureWatchHistoryTable, LectureWatchHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LectureWatchHistoryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coursenumMeta =
      const VerificationMeta('coursenum');
  @override
  late final GeneratedColumn<String> coursenum = GeneratedColumn<String>(
      'coursenum', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES course_preferences (coursenum)'));
  static const VerificationMeta _lectureKeyMeta =
      const VerificationMeta('lectureKey');
  @override
  late final GeneratedColumn<String> lectureKey = GeneratedColumn<String>(
      'lecture_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _positionMeta =
      const VerificationMeta('position');
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
      'position', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lectureLengthMeta =
      const VerificationMeta('lectureLength');
  @override
  late final GeneratedColumn<int> lectureLength = GeneratedColumn<int>(
      'lecture_length', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [coursenum, lectureKey, position, lectureLength, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lecture_watch_history';
  @override
  VerificationContext validateIntegrity(
      Insertable<LectureWatchHistoryData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('coursenum')) {
      context.handle(_coursenumMeta,
          coursenum.isAcceptableOrUnknown(data['coursenum']!, _coursenumMeta));
    } else if (isInserting) {
      context.missing(_coursenumMeta);
    }
    if (data.containsKey('lecture_key')) {
      context.handle(
          _lectureKeyMeta,
          lectureKey.isAcceptableOrUnknown(
              data['lecture_key']!, _lectureKeyMeta));
    } else if (isInserting) {
      context.missing(_lectureKeyMeta);
    }
    if (data.containsKey('position')) {
      context.handle(_positionMeta,
          position.isAcceptableOrUnknown(data['position']!, _positionMeta));
    } else if (isInserting) {
      context.missing(_positionMeta);
    }
    if (data.containsKey('lecture_length')) {
      context.handle(
          _lectureLengthMeta,
          lectureLength.isAcceptableOrUnknown(
              data['lecture_length']!, _lectureLengthMeta));
    } else if (isInserting) {
      context.missing(_lectureLengthMeta);
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
  Set<GeneratedColumn> get $primaryKey => {coursenum, lectureKey};
  @override
  LectureWatchHistoryData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LectureWatchHistoryData(
      coursenum: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}coursenum'])!,
      lectureKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lecture_key'])!,
      position: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}position'])!,
      lectureLength: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}lecture_length'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LectureWatchHistoryTable createAlias(String alias) {
    return $LectureWatchHistoryTable(attachedDatabase, alias);
  }
}

class LectureWatchHistoryData extends DataClass
    implements Insertable<LectureWatchHistoryData> {
  final String coursenum;
  final String lectureKey;
  final int position;
  final int lectureLength;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LectureWatchHistoryData(
      {required this.coursenum,
      required this.lectureKey,
      required this.position,
      required this.lectureLength,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['coursenum'] = Variable<String>(coursenum);
    map['lecture_key'] = Variable<String>(lectureKey);
    map['position'] = Variable<int>(position);
    map['lecture_length'] = Variable<int>(lectureLength);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LectureWatchHistoryCompanion toCompanion(bool nullToAbsent) {
    return LectureWatchHistoryCompanion(
      coursenum: Value(coursenum),
      lectureKey: Value(lectureKey),
      position: Value(position),
      lectureLength: Value(lectureLength),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LectureWatchHistoryData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LectureWatchHistoryData(
      coursenum: serializer.fromJson<String>(json['coursenum']),
      lectureKey: serializer.fromJson<String>(json['lectureKey']),
      position: serializer.fromJson<int>(json['position']),
      lectureLength: serializer.fromJson<int>(json['lectureLength']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coursenum': serializer.toJson<String>(coursenum),
      'lectureKey': serializer.toJson<String>(lectureKey),
      'position': serializer.toJson<int>(position),
      'lectureLength': serializer.toJson<int>(lectureLength),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LectureWatchHistoryData copyWith(
          {String? coursenum,
          String? lectureKey,
          int? position,
          int? lectureLength,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LectureWatchHistoryData(
        coursenum: coursenum ?? this.coursenum,
        lectureKey: lectureKey ?? this.lectureKey,
        position: position ?? this.position,
        lectureLength: lectureLength ?? this.lectureLength,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LectureWatchHistoryData copyWithCompanion(LectureWatchHistoryCompanion data) {
    return LectureWatchHistoryData(
      coursenum: data.coursenum.present ? data.coursenum.value : this.coursenum,
      lectureKey:
          data.lectureKey.present ? data.lectureKey.value : this.lectureKey,
      position: data.position.present ? data.position.value : this.position,
      lectureLength: data.lectureLength.present
          ? data.lectureLength.value
          : this.lectureLength,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LectureWatchHistoryData(')
          ..write('coursenum: $coursenum, ')
          ..write('lectureKey: $lectureKey, ')
          ..write('position: $position, ')
          ..write('lectureLength: $lectureLength, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      coursenum, lectureKey, position, lectureLength, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LectureWatchHistoryData &&
          other.coursenum == this.coursenum &&
          other.lectureKey == this.lectureKey &&
          other.position == this.position &&
          other.lectureLength == this.lectureLength &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LectureWatchHistoryCompanion
    extends UpdateCompanion<LectureWatchHistoryData> {
  final Value<String> coursenum;
  final Value<String> lectureKey;
  final Value<int> position;
  final Value<int> lectureLength;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LectureWatchHistoryCompanion({
    this.coursenum = const Value.absent(),
    this.lectureKey = const Value.absent(),
    this.position = const Value.absent(),
    this.lectureLength = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LectureWatchHistoryCompanion.insert({
    required String coursenum,
    required String lectureKey,
    required int position,
    required int lectureLength,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : coursenum = Value(coursenum),
        lectureKey = Value(lectureKey),
        position = Value(position),
        lectureLength = Value(lectureLength);
  static Insertable<LectureWatchHistoryData> custom({
    Expression<String>? coursenum,
    Expression<String>? lectureKey,
    Expression<int>? position,
    Expression<int>? lectureLength,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coursenum != null) 'coursenum': coursenum,
      if (lectureKey != null) 'lecture_key': lectureKey,
      if (position != null) 'position': position,
      if (lectureLength != null) 'lecture_length': lectureLength,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LectureWatchHistoryCompanion copyWith(
      {Value<String>? coursenum,
      Value<String>? lectureKey,
      Value<int>? position,
      Value<int>? lectureLength,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LectureWatchHistoryCompanion(
      coursenum: coursenum ?? this.coursenum,
      lectureKey: lectureKey ?? this.lectureKey,
      position: position ?? this.position,
      lectureLength: lectureLength ?? this.lectureLength,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coursenum.present) {
      map['coursenum'] = Variable<String>(coursenum.value);
    }
    if (lectureKey.present) {
      map['lecture_key'] = Variable<String>(lectureKey.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (lectureLength.present) {
      map['lecture_length'] = Variable<int>(lectureLength.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LectureWatchHistoryCompanion(')
          ..write('coursenum: $coursenum, ')
          ..write('lectureKey: $lectureKey, ')
          ..write('position: $position, ')
          ..write('lectureLength: $lectureLength, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MitOcwDatabase extends GeneratedDatabase {
  _$MitOcwDatabase(QueryExecutor e) : super(e);
  $MitOcwDatabaseManager get managers => $MitOcwDatabaseManager(this);
  late final $PlaylistTable playlist = $PlaylistTable(this);
  late final $PlaylistCourseTable playlistCourse = $PlaylistCourseTable(this);
  late final $CoursePreferencesTable coursePreferences =
      $CoursePreferencesTable(this);
  late final $LectureWatchHistoryTable lectureWatchHistory =
      $LectureWatchHistoryTable(this);
  late final Index courseWatchHistory = Index('course_watch_history',
      'CREATE INDEX course_watch_history ON lecture_watch_history (coursenum)');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        playlist,
        playlistCourse,
        coursePreferences,
        lectureWatchHistory,
        courseWatchHistory
      ];
}

typedef $$PlaylistTableCreateCompanionBuilder = PlaylistCompanion Function({
  Value<int> id,
  required String name,
  Value<DateTime> createdAt,
});
typedef $$PlaylistTableUpdateCompanionBuilder = PlaylistCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<DateTime> createdAt,
});

final class $$PlaylistTableReferences
    extends BaseReferences<_$MitOcwDatabase, $PlaylistTable, PlaylistData> {
  $$PlaylistTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlaylistCourseTable, List<PlaylistCourseData>>
      _playlistCourseRefsTable(_$MitOcwDatabase db) =>
          MultiTypedResultKey.fromTable(db.playlistCourse,
              aliasName: $_aliasNameGenerator(
                  db.playlist.id, db.playlistCourse.playlistId));

  $$PlaylistCourseTableProcessedTableManager get playlistCourseRefs {
    final manager = $$PlaylistCourseTableTableManager($_db, $_db.playlistCourse)
        .filter((f) => f.playlistId.id($_item.id));

    final cache = $_typedResult.readTableOrNull(_playlistCourseRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlaylistTableFilterComposer
    extends FilterComposer<_$MitOcwDatabase, $PlaylistTable> {
  $$PlaylistTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter playlistCourseRefs(
      ComposableFilter Function($$PlaylistCourseTableFilterComposer f) f) {
    final $$PlaylistCourseTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $state.db.playlistCourse,
        getReferencedColumn: (t) => t.playlistId,
        builder: (joinBuilder, parentComposers) =>
            $$PlaylistCourseTableFilterComposer(ComposerState($state.db,
                $state.db.playlistCourse, joinBuilder, parentComposers)));
    return f(composer);
  }
}

class $$PlaylistTableOrderingComposer
    extends OrderingComposer<_$MitOcwDatabase, $PlaylistTable> {
  $$PlaylistTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$PlaylistTableTableManager extends RootTableManager<
    _$MitOcwDatabase,
    $PlaylistTable,
    PlaylistData,
    $$PlaylistTableFilterComposer,
    $$PlaylistTableOrderingComposer,
    $$PlaylistTableCreateCompanionBuilder,
    $$PlaylistTableUpdateCompanionBuilder,
    (PlaylistData, $$PlaylistTableReferences),
    PlaylistData,
    PrefetchHooks Function({bool playlistCourseRefs})> {
  $$PlaylistTableTableManager(_$MitOcwDatabase db, $PlaylistTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlaylistTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PlaylistTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PlaylistCompanion(
            id: id,
            name: name,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              PlaylistCompanion.insert(
            id: id,
            name: name,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$PlaylistTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({playlistCourseRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playlistCourseRefs) db.playlistCourse
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playlistCourseRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$PlaylistTableReferences
                            ._playlistCourseRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlaylistTableReferences(db, table, p0)
                                .playlistCourseRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.playlistId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlaylistTableProcessedTableManager = ProcessedTableManager<
    _$MitOcwDatabase,
    $PlaylistTable,
    PlaylistData,
    $$PlaylistTableFilterComposer,
    $$PlaylistTableOrderingComposer,
    $$PlaylistTableCreateCompanionBuilder,
    $$PlaylistTableUpdateCompanionBuilder,
    (PlaylistData, $$PlaylistTableReferences),
    PlaylistData,
    PrefetchHooks Function({bool playlistCourseRefs})>;
typedef $$PlaylistCourseTableCreateCompanionBuilder = PlaylistCourseCompanion
    Function({
  required int playlistId,
  required String coursenum,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$PlaylistCourseTableUpdateCompanionBuilder = PlaylistCourseCompanion
    Function({
  Value<int> playlistId,
  Value<String> coursenum,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$PlaylistCourseTableReferences extends BaseReferences<
    _$MitOcwDatabase, $PlaylistCourseTable, PlaylistCourseData> {
  $$PlaylistCourseTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PlaylistTable _playlistIdTable(_$MitOcwDatabase db) =>
      db.playlist.createAlias(
          $_aliasNameGenerator(db.playlistCourse.playlistId, db.playlist.id));

  $$PlaylistTableProcessedTableManager? get playlistId {
    if ($_item.playlistId == null) return null;
    final manager = $$PlaylistTableTableManager($_db, $_db.playlist)
        .filter((f) => f.id($_item.playlistId!));
    final item = $_typedResult.readTableOrNull(_playlistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PlaylistCourseTableFilterComposer
    extends FilterComposer<_$MitOcwDatabase, $PlaylistCourseTable> {
  $$PlaylistCourseTableFilterComposer(super.$state);
  ColumnFilters<String> get coursenum => $state.composableBuilder(
      column: $state.table.coursenum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PlaylistTableFilterComposer get playlistId {
    final $$PlaylistTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $state.db.playlist,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PlaylistTableFilterComposer(ComposerState(
                $state.db, $state.db.playlist, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PlaylistCourseTableOrderingComposer
    extends OrderingComposer<_$MitOcwDatabase, $PlaylistCourseTable> {
  $$PlaylistCourseTableOrderingComposer(super.$state);
  ColumnOrderings<String> get coursenum => $state.composableBuilder(
      column: $state.table.coursenum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PlaylistTableOrderingComposer get playlistId {
    final $$PlaylistTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $state.db.playlist,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PlaylistTableOrderingComposer(ComposerState(
                $state.db, $state.db.playlist, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PlaylistCourseTableTableManager extends RootTableManager<
    _$MitOcwDatabase,
    $PlaylistCourseTable,
    PlaylistCourseData,
    $$PlaylistCourseTableFilterComposer,
    $$PlaylistCourseTableOrderingComposer,
    $$PlaylistCourseTableCreateCompanionBuilder,
    $$PlaylistCourseTableUpdateCompanionBuilder,
    (PlaylistCourseData, $$PlaylistCourseTableReferences),
    PlaylistCourseData,
    PrefetchHooks Function({bool playlistId})> {
  $$PlaylistCourseTableTableManager(
      _$MitOcwDatabase db, $PlaylistCourseTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlaylistCourseTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PlaylistCourseTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> playlistId = const Value.absent(),
            Value<String> coursenum = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistCourseCompanion(
            playlistId: playlistId,
            coursenum: coursenum,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required int playlistId,
            required String coursenum,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlaylistCourseCompanion.insert(
            playlistId: playlistId,
            coursenum: coursenum,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlaylistCourseTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({playlistId = false}) {
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
                      dynamic>>(state) {
                if (playlistId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.playlistId,
                    referencedTable:
                        $$PlaylistCourseTableReferences._playlistIdTable(db),
                    referencedColumn:
                        $$PlaylistCourseTableReferences._playlistIdTable(db).id,
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

typedef $$PlaylistCourseTableProcessedTableManager = ProcessedTableManager<
    _$MitOcwDatabase,
    $PlaylistCourseTable,
    PlaylistCourseData,
    $$PlaylistCourseTableFilterComposer,
    $$PlaylistCourseTableOrderingComposer,
    $$PlaylistCourseTableCreateCompanionBuilder,
    $$PlaylistCourseTableUpdateCompanionBuilder,
    (PlaylistCourseData, $$PlaylistCourseTableReferences),
    PlaylistCourseData,
    PrefetchHooks Function({bool playlistId})>;
typedef $$CoursePreferencesTableCreateCompanionBuilder
    = CoursePreferencesCompanion Function({
  required String coursenum,
  Value<bool> showInContinueWatching,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$CoursePreferencesTableUpdateCompanionBuilder
    = CoursePreferencesCompanion Function({
  Value<String> coursenum,
  Value<bool> showInContinueWatching,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$CoursePreferencesTableReferences extends BaseReferences<
    _$MitOcwDatabase, $CoursePreferencesTable, CoursePreference> {
  $$CoursePreferencesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LectureWatchHistoryTable,
      List<LectureWatchHistoryData>> _lectureWatchHistoryRefsTable(
          _$MitOcwDatabase db) =>
      MultiTypedResultKey.fromTable(db.lectureWatchHistory,
          aliasName: $_aliasNameGenerator(db.coursePreferences.coursenum,
              db.lectureWatchHistory.coursenum));

  $$LectureWatchHistoryTableProcessedTableManager get lectureWatchHistoryRefs {
    final manager =
        $$LectureWatchHistoryTableTableManager($_db, $_db.lectureWatchHistory)
            .filter((f) => f.coursenum.coursenum($_item.coursenum));

    final cache =
        $_typedResult.readTableOrNull(_lectureWatchHistoryRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CoursePreferencesTableFilterComposer
    extends FilterComposer<_$MitOcwDatabase, $CoursePreferencesTable> {
  $$CoursePreferencesTableFilterComposer(super.$state);
  ColumnFilters<String> get coursenum => $state.composableBuilder(
      column: $state.table.coursenum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get showInContinueWatching => $state.composableBuilder(
      column: $state.table.showInContinueWatching,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter lectureWatchHistoryRefs(
      ComposableFilter Function($$LectureWatchHistoryTableFilterComposer f) f) {
    final $$LectureWatchHistoryTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.coursenum,
            referencedTable: $state.db.lectureWatchHistory,
            getReferencedColumn: (t) => t.coursenum,
            builder: (joinBuilder, parentComposers) =>
                $$LectureWatchHistoryTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.lectureWatchHistory,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$CoursePreferencesTableOrderingComposer
    extends OrderingComposer<_$MitOcwDatabase, $CoursePreferencesTable> {
  $$CoursePreferencesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get coursenum => $state.composableBuilder(
      column: $state.table.coursenum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get showInContinueWatching => $state.composableBuilder(
      column: $state.table.showInContinueWatching,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $$CoursePreferencesTableTableManager extends RootTableManager<
    _$MitOcwDatabase,
    $CoursePreferencesTable,
    CoursePreference,
    $$CoursePreferencesTableFilterComposer,
    $$CoursePreferencesTableOrderingComposer,
    $$CoursePreferencesTableCreateCompanionBuilder,
    $$CoursePreferencesTableUpdateCompanionBuilder,
    (CoursePreference, $$CoursePreferencesTableReferences),
    CoursePreference,
    PrefetchHooks Function({bool lectureWatchHistoryRefs})> {
  $$CoursePreferencesTableTableManager(
      _$MitOcwDatabase db, $CoursePreferencesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$CoursePreferencesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$CoursePreferencesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> coursenum = const Value.absent(),
            Value<bool> showInContinueWatching = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CoursePreferencesCompanion(
            coursenum: coursenum,
            showInContinueWatching: showInContinueWatching,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String coursenum,
            Value<bool> showInContinueWatching = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CoursePreferencesCompanion.insert(
            coursenum: coursenum,
            showInContinueWatching: showInContinueWatching,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CoursePreferencesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({lectureWatchHistoryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (lectureWatchHistoryRefs) db.lectureWatchHistory
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lectureWatchHistoryRefs)
                    await $_getPrefetchedData(
                        currentTable: table,
                        referencedTable: $$CoursePreferencesTableReferences
                            ._lectureWatchHistoryRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CoursePreferencesTableReferences(db, table, p0)
                                .lectureWatchHistoryRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.coursenum == item.coursenum),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CoursePreferencesTableProcessedTableManager = ProcessedTableManager<
    _$MitOcwDatabase,
    $CoursePreferencesTable,
    CoursePreference,
    $$CoursePreferencesTableFilterComposer,
    $$CoursePreferencesTableOrderingComposer,
    $$CoursePreferencesTableCreateCompanionBuilder,
    $$CoursePreferencesTableUpdateCompanionBuilder,
    (CoursePreference, $$CoursePreferencesTableReferences),
    CoursePreference,
    PrefetchHooks Function({bool lectureWatchHistoryRefs})>;
typedef $$LectureWatchHistoryTableCreateCompanionBuilder
    = LectureWatchHistoryCompanion Function({
  required String coursenum,
  required String lectureKey,
  required int position,
  required int lectureLength,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LectureWatchHistoryTableUpdateCompanionBuilder
    = LectureWatchHistoryCompanion Function({
  Value<String> coursenum,
  Value<String> lectureKey,
  Value<int> position,
  Value<int> lectureLength,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LectureWatchHistoryTableReferences extends BaseReferences<
    _$MitOcwDatabase, $LectureWatchHistoryTable, LectureWatchHistoryData> {
  $$LectureWatchHistoryTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CoursePreferencesTable _coursenumTable(_$MitOcwDatabase db) =>
      db.coursePreferences.createAlias($_aliasNameGenerator(
          db.lectureWatchHistory.coursenum, db.coursePreferences.coursenum));

  $$CoursePreferencesTableProcessedTableManager? get coursenum {
    if ($_item.coursenum == null) return null;
    final manager =
        $$CoursePreferencesTableTableManager($_db, $_db.coursePreferences)
            .filter((f) => f.coursenum($_item.coursenum!));
    final item = $_typedResult.readTableOrNull(_coursenumTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LectureWatchHistoryTableFilterComposer
    extends FilterComposer<_$MitOcwDatabase, $LectureWatchHistoryTable> {
  $$LectureWatchHistoryTableFilterComposer(super.$state);
  ColumnFilters<String> get lectureKey => $state.composableBuilder(
      column: $state.table.lectureKey,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get lectureLength => $state.composableBuilder(
      column: $state.table.lectureLength,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$CoursePreferencesTableFilterComposer get coursenum {
    final $$CoursePreferencesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.coursenum,
            referencedTable: $state.db.coursePreferences,
            getReferencedColumn: (t) => t.coursenum,
            builder: (joinBuilder, parentComposers) =>
                $$CoursePreferencesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.coursePreferences,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$LectureWatchHistoryTableOrderingComposer
    extends OrderingComposer<_$MitOcwDatabase, $LectureWatchHistoryTable> {
  $$LectureWatchHistoryTableOrderingComposer(super.$state);
  ColumnOrderings<String> get lectureKey => $state.composableBuilder(
      column: $state.table.lectureKey,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get position => $state.composableBuilder(
      column: $state.table.position,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get lectureLength => $state.composableBuilder(
      column: $state.table.lectureLength,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$CoursePreferencesTableOrderingComposer get coursenum {
    final $$CoursePreferencesTableOrderingComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.coursenum,
            referencedTable: $state.db.coursePreferences,
            getReferencedColumn: (t) => t.coursenum,
            builder: (joinBuilder, parentComposers) =>
                $$CoursePreferencesTableOrderingComposer(ComposerState(
                    $state.db,
                    $state.db.coursePreferences,
                    joinBuilder,
                    parentComposers)));
    return composer;
  }
}

class $$LectureWatchHistoryTableTableManager extends RootTableManager<
    _$MitOcwDatabase,
    $LectureWatchHistoryTable,
    LectureWatchHistoryData,
    $$LectureWatchHistoryTableFilterComposer,
    $$LectureWatchHistoryTableOrderingComposer,
    $$LectureWatchHistoryTableCreateCompanionBuilder,
    $$LectureWatchHistoryTableUpdateCompanionBuilder,
    (LectureWatchHistoryData, $$LectureWatchHistoryTableReferences),
    LectureWatchHistoryData,
    PrefetchHooks Function({bool coursenum})> {
  $$LectureWatchHistoryTableTableManager(
      _$MitOcwDatabase db, $LectureWatchHistoryTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $$LectureWatchHistoryTableFilterComposer(
              ComposerState(db, table)),
          orderingComposer: $$LectureWatchHistoryTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> coursenum = const Value.absent(),
            Value<String> lectureKey = const Value.absent(),
            Value<int> position = const Value.absent(),
            Value<int> lectureLength = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LectureWatchHistoryCompanion(
            coursenum: coursenum,
            lectureKey: lectureKey,
            position: position,
            lectureLength: lectureLength,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String coursenum,
            required String lectureKey,
            required int position,
            required int lectureLength,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LectureWatchHistoryCompanion.insert(
            coursenum: coursenum,
            lectureKey: lectureKey,
            position: position,
            lectureLength: lectureLength,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LectureWatchHistoryTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({coursenum = false}) {
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
                      dynamic>>(state) {
                if (coursenum) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.coursenum,
                    referencedTable: $$LectureWatchHistoryTableReferences
                        ._coursenumTable(db),
                    referencedColumn: $$LectureWatchHistoryTableReferences
                        ._coursenumTable(db)
                        .coursenum,
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

typedef $$LectureWatchHistoryTableProcessedTableManager = ProcessedTableManager<
    _$MitOcwDatabase,
    $LectureWatchHistoryTable,
    LectureWatchHistoryData,
    $$LectureWatchHistoryTableFilterComposer,
    $$LectureWatchHistoryTableOrderingComposer,
    $$LectureWatchHistoryTableCreateCompanionBuilder,
    $$LectureWatchHistoryTableUpdateCompanionBuilder,
    (LectureWatchHistoryData, $$LectureWatchHistoryTableReferences),
    LectureWatchHistoryData,
    PrefetchHooks Function({bool coursenum})>;

class $MitOcwDatabaseManager {
  final _$MitOcwDatabase _db;
  $MitOcwDatabaseManager(this._db);
  $$PlaylistTableTableManager get playlist =>
      $$PlaylistTableTableManager(_db, _db.playlist);
  $$PlaylistCourseTableTableManager get playlistCourse =>
      $$PlaylistCourseTableTableManager(_db, _db.playlistCourse);
  $$CoursePreferencesTableTableManager get coursePreferences =>
      $$CoursePreferencesTableTableManager(_db, _db.coursePreferences);
  $$LectureWatchHistoryTableTableManager get lectureWatchHistory =>
      $$LectureWatchHistoryTableTableManager(_db, _db.lectureWatchHistory);
}
