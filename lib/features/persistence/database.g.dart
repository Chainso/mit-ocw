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

abstract class _$MitOcwDatabase extends GeneratedDatabase {
  _$MitOcwDatabase(QueryExecutor e) : super(e);
  $MitOcwDatabaseManager get managers => $MitOcwDatabaseManager(this);
  late final $PlaylistTable playlist = $PlaylistTable(this);
  late final $PlaylistCourseTable playlistCourse = $PlaylistCourseTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [playlist, playlistCourse];
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

class $MitOcwDatabaseManager {
  final _$MitOcwDatabase _db;
  $MitOcwDatabaseManager(this._db);
  $$PlaylistTableTableManager get playlist =>
      $$PlaylistTableTableManager(_db, _db.playlist);
  $$PlaylistCourseTableTableManager get playlistCourse =>
      $$PlaylistCourseTableTableManager(_db, _db.playlistCourse);
}
