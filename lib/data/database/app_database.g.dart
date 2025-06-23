// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BarangTable extends Barang with TableInfo<$BarangTable, BarangData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BarangTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaBarangMeta =
      const VerificationMeta('namaBarang');
  @override
  late final GeneratedColumn<String> namaBarang = GeneratedColumn<String>(
      'nama_barang', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kategoriIdMeta =
      const VerificationMeta('kategoriId');
  @override
  late final GeneratedColumn<int> kategoriId = GeneratedColumn<int>(
      'kategori_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _stokMeta = const VerificationMeta('stok');
  @override
  late final GeneratedColumn<int> stok = GeneratedColumn<int>(
      'stok', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _kelompokBarangMeta =
      const VerificationMeta('kelompokBarang');
  @override
  late final GeneratedColumn<String> kelompokBarang = GeneratedColumn<String>(
      'kelompok_barang', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _hargaMeta = const VerificationMeta('harga');
  @override
  late final GeneratedColumn<int> harga = GeneratedColumn<int>(
      'harga', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, namaBarang, kategoriId, stok, kelompokBarang, harga];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'barang';
  @override
  VerificationContext validateIntegrity(Insertable<BarangData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_barang')) {
      context.handle(
          _namaBarangMeta,
          namaBarang.isAcceptableOrUnknown(
              data['nama_barang']!, _namaBarangMeta));
    } else if (isInserting) {
      context.missing(_namaBarangMeta);
    }
    if (data.containsKey('kategori_id')) {
      context.handle(
          _kategoriIdMeta,
          kategoriId.isAcceptableOrUnknown(
              data['kategori_id']!, _kategoriIdMeta));
    } else if (isInserting) {
      context.missing(_kategoriIdMeta);
    }
    if (data.containsKey('stok')) {
      context.handle(
          _stokMeta, stok.isAcceptableOrUnknown(data['stok']!, _stokMeta));
    } else if (isInserting) {
      context.missing(_stokMeta);
    }
    if (data.containsKey('kelompok_barang')) {
      context.handle(
          _kelompokBarangMeta,
          kelompokBarang.isAcceptableOrUnknown(
              data['kelompok_barang']!, _kelompokBarangMeta));
    } else if (isInserting) {
      context.missing(_kelompokBarangMeta);
    }
    if (data.containsKey('harga')) {
      context.handle(
          _hargaMeta, harga.isAcceptableOrUnknown(data['harga']!, _hargaMeta));
    } else if (isInserting) {
      context.missing(_hargaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BarangData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BarangData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaBarang: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_barang'])!,
      kategoriId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}kategori_id'])!,
      stok: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stok'])!,
      kelompokBarang: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}kelompok_barang'])!,
      harga: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}harga'])!,
    );
  }

  @override
  $BarangTable createAlias(String alias) {
    return $BarangTable(attachedDatabase, alias);
  }
}

class BarangData extends DataClass implements Insertable<BarangData> {
  final int id;
  final String namaBarang;
  final int kategoriId;
  final int stok;
  final String kelompokBarang;
  final int harga;
  const BarangData(
      {required this.id,
      required this.namaBarang,
      required this.kategoriId,
      required this.stok,
      required this.kelompokBarang,
      required this.harga});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_barang'] = Variable<String>(namaBarang);
    map['kategori_id'] = Variable<int>(kategoriId);
    map['stok'] = Variable<int>(stok);
    map['kelompok_barang'] = Variable<String>(kelompokBarang);
    map['harga'] = Variable<int>(harga);
    return map;
  }

  BarangCompanion toCompanion(bool nullToAbsent) {
    return BarangCompanion(
      id: Value(id),
      namaBarang: Value(namaBarang),
      kategoriId: Value(kategoriId),
      stok: Value(stok),
      kelompokBarang: Value(kelompokBarang),
      harga: Value(harga),
    );
  }

  factory BarangData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BarangData(
      id: serializer.fromJson<int>(json['id']),
      namaBarang: serializer.fromJson<String>(json['namaBarang']),
      kategoriId: serializer.fromJson<int>(json['kategoriId']),
      stok: serializer.fromJson<int>(json['stok']),
      kelompokBarang: serializer.fromJson<String>(json['kelompokBarang']),
      harga: serializer.fromJson<int>(json['harga']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaBarang': serializer.toJson<String>(namaBarang),
      'kategoriId': serializer.toJson<int>(kategoriId),
      'stok': serializer.toJson<int>(stok),
      'kelompokBarang': serializer.toJson<String>(kelompokBarang),
      'harga': serializer.toJson<int>(harga),
    };
  }

  BarangData copyWith(
          {int? id,
          String? namaBarang,
          int? kategoriId,
          int? stok,
          String? kelompokBarang,
          int? harga}) =>
      BarangData(
        id: id ?? this.id,
        namaBarang: namaBarang ?? this.namaBarang,
        kategoriId: kategoriId ?? this.kategoriId,
        stok: stok ?? this.stok,
        kelompokBarang: kelompokBarang ?? this.kelompokBarang,
        harga: harga ?? this.harga,
      );
  BarangData copyWithCompanion(BarangCompanion data) {
    return BarangData(
      id: data.id.present ? data.id.value : this.id,
      namaBarang:
          data.namaBarang.present ? data.namaBarang.value : this.namaBarang,
      kategoriId:
          data.kategoriId.present ? data.kategoriId.value : this.kategoriId,
      stok: data.stok.present ? data.stok.value : this.stok,
      kelompokBarang: data.kelompokBarang.present
          ? data.kelompokBarang.value
          : this.kelompokBarang,
      harga: data.harga.present ? data.harga.value : this.harga,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BarangData(')
          ..write('id: $id, ')
          ..write('namaBarang: $namaBarang, ')
          ..write('kategoriId: $kategoriId, ')
          ..write('stok: $stok, ')
          ..write('kelompokBarang: $kelompokBarang, ')
          ..write('harga: $harga')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, namaBarang, kategoriId, stok, kelompokBarang, harga);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BarangData &&
          other.id == this.id &&
          other.namaBarang == this.namaBarang &&
          other.kategoriId == this.kategoriId &&
          other.stok == this.stok &&
          other.kelompokBarang == this.kelompokBarang &&
          other.harga == this.harga);
}

class BarangCompanion extends UpdateCompanion<BarangData> {
  final Value<int> id;
  final Value<String> namaBarang;
  final Value<int> kategoriId;
  final Value<int> stok;
  final Value<String> kelompokBarang;
  final Value<int> harga;
  const BarangCompanion({
    this.id = const Value.absent(),
    this.namaBarang = const Value.absent(),
    this.kategoriId = const Value.absent(),
    this.stok = const Value.absent(),
    this.kelompokBarang = const Value.absent(),
    this.harga = const Value.absent(),
  });
  BarangCompanion.insert({
    this.id = const Value.absent(),
    required String namaBarang,
    required int kategoriId,
    required int stok,
    required String kelompokBarang,
    required int harga,
  })  : namaBarang = Value(namaBarang),
        kategoriId = Value(kategoriId),
        stok = Value(stok),
        kelompokBarang = Value(kelompokBarang),
        harga = Value(harga);
  static Insertable<BarangData> custom({
    Expression<int>? id,
    Expression<String>? namaBarang,
    Expression<int>? kategoriId,
    Expression<int>? stok,
    Expression<String>? kelompokBarang,
    Expression<int>? harga,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaBarang != null) 'nama_barang': namaBarang,
      if (kategoriId != null) 'kategori_id': kategoriId,
      if (stok != null) 'stok': stok,
      if (kelompokBarang != null) 'kelompok_barang': kelompokBarang,
      if (harga != null) 'harga': harga,
    });
  }

  BarangCompanion copyWith(
      {Value<int>? id,
      Value<String>? namaBarang,
      Value<int>? kategoriId,
      Value<int>? stok,
      Value<String>? kelompokBarang,
      Value<int>? harga}) {
    return BarangCompanion(
      id: id ?? this.id,
      namaBarang: namaBarang ?? this.namaBarang,
      kategoriId: kategoriId ?? this.kategoriId,
      stok: stok ?? this.stok,
      kelompokBarang: kelompokBarang ?? this.kelompokBarang,
      harga: harga ?? this.harga,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaBarang.present) {
      map['nama_barang'] = Variable<String>(namaBarang.value);
    }
    if (kategoriId.present) {
      map['kategori_id'] = Variable<int>(kategoriId.value);
    }
    if (stok.present) {
      map['stok'] = Variable<int>(stok.value);
    }
    if (kelompokBarang.present) {
      map['kelompok_barang'] = Variable<String>(kelompokBarang.value);
    }
    if (harga.present) {
      map['harga'] = Variable<int>(harga.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BarangCompanion(')
          ..write('id: $id, ')
          ..write('namaBarang: $namaBarang, ')
          ..write('kategoriId: $kategoriId, ')
          ..write('stok: $stok, ')
          ..write('kelompokBarang: $kelompokBarang, ')
          ..write('harga: $harga')
          ..write(')'))
        .toString();
  }
}

class $KategoriTable extends Kategori
    with TableInfo<$KategoriTable, KategoriData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KategoriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _namaKategoriMeta =
      const VerificationMeta('namaKategori');
  @override
  late final GeneratedColumn<String> namaKategori = GeneratedColumn<String>(
      'nama_kategori', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, namaKategori];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kategori';
  @override
  VerificationContext validateIntegrity(Insertable<KategoriData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama_kategori')) {
      context.handle(
          _namaKategoriMeta,
          namaKategori.isAcceptableOrUnknown(
              data['nama_kategori']!, _namaKategoriMeta));
    } else if (isInserting) {
      context.missing(_namaKategoriMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KategoriData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KategoriData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      namaKategori: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nama_kategori'])!,
    );
  }

  @override
  $KategoriTable createAlias(String alias) {
    return $KategoriTable(attachedDatabase, alias);
  }
}

class KategoriData extends DataClass implements Insertable<KategoriData> {
  final int id;
  final String namaKategori;
  const KategoriData({required this.id, required this.namaKategori});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama_kategori'] = Variable<String>(namaKategori);
    return map;
  }

  KategoriCompanion toCompanion(bool nullToAbsent) {
    return KategoriCompanion(
      id: Value(id),
      namaKategori: Value(namaKategori),
    );
  }

  factory KategoriData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KategoriData(
      id: serializer.fromJson<int>(json['id']),
      namaKategori: serializer.fromJson<String>(json['namaKategori']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'namaKategori': serializer.toJson<String>(namaKategori),
    };
  }

  KategoriData copyWith({int? id, String? namaKategori}) => KategoriData(
        id: id ?? this.id,
        namaKategori: namaKategori ?? this.namaKategori,
      );
  KategoriData copyWithCompanion(KategoriCompanion data) {
    return KategoriData(
      id: data.id.present ? data.id.value : this.id,
      namaKategori: data.namaKategori.present
          ? data.namaKategori.value
          : this.namaKategori,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KategoriData(')
          ..write('id: $id, ')
          ..write('namaKategori: $namaKategori')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, namaKategori);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KategoriData &&
          other.id == this.id &&
          other.namaKategori == this.namaKategori);
}

class KategoriCompanion extends UpdateCompanion<KategoriData> {
  final Value<int> id;
  final Value<String> namaKategori;
  const KategoriCompanion({
    this.id = const Value.absent(),
    this.namaKategori = const Value.absent(),
  });
  KategoriCompanion.insert({
    this.id = const Value.absent(),
    required String namaKategori,
  }) : namaKategori = Value(namaKategori);
  static Insertable<KategoriData> custom({
    Expression<int>? id,
    Expression<String>? namaKategori,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (namaKategori != null) 'nama_kategori': namaKategori,
    });
  }

  KategoriCompanion copyWith({Value<int>? id, Value<String>? namaKategori}) {
    return KategoriCompanion(
      id: id ?? this.id,
      namaKategori: namaKategori ?? this.namaKategori,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (namaKategori.present) {
      map['nama_kategori'] = Variable<String>(namaKategori.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KategoriCompanion(')
          ..write('id: $id, ')
          ..write('namaKategori: $namaKategori')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BarangTable barang = $BarangTable(this);
  late final $KategoriTable kategori = $KategoriTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [barang, kategori];
}

typedef $$BarangTableCreateCompanionBuilder = BarangCompanion Function({
  Value<int> id,
  required String namaBarang,
  required int kategoriId,
  required int stok,
  required String kelompokBarang,
  required int harga,
});
typedef $$BarangTableUpdateCompanionBuilder = BarangCompanion Function({
  Value<int> id,
  Value<String> namaBarang,
  Value<int> kategoriId,
  Value<int> stok,
  Value<String> kelompokBarang,
  Value<int> harga,
});

class $$BarangTableFilterComposer
    extends Composer<_$AppDatabase, $BarangTable> {
  $$BarangTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namaBarang => $composableBuilder(
      column: $table.namaBarang, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get kategoriId => $composableBuilder(
      column: $table.kategoriId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stok => $composableBuilder(
      column: $table.stok, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get kelompokBarang => $composableBuilder(
      column: $table.kelompokBarang,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get harga => $composableBuilder(
      column: $table.harga, builder: (column) => ColumnFilters(column));
}

class $$BarangTableOrderingComposer
    extends Composer<_$AppDatabase, $BarangTable> {
  $$BarangTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namaBarang => $composableBuilder(
      column: $table.namaBarang, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get kategoriId => $composableBuilder(
      column: $table.kategoriId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stok => $composableBuilder(
      column: $table.stok, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get kelompokBarang => $composableBuilder(
      column: $table.kelompokBarang,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get harga => $composableBuilder(
      column: $table.harga, builder: (column) => ColumnOrderings(column));
}

class $$BarangTableAnnotationComposer
    extends Composer<_$AppDatabase, $BarangTable> {
  $$BarangTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaBarang => $composableBuilder(
      column: $table.namaBarang, builder: (column) => column);

  GeneratedColumn<int> get kategoriId => $composableBuilder(
      column: $table.kategoriId, builder: (column) => column);

  GeneratedColumn<int> get stok =>
      $composableBuilder(column: $table.stok, builder: (column) => column);

  GeneratedColumn<String> get kelompokBarang => $composableBuilder(
      column: $table.kelompokBarang, builder: (column) => column);

  GeneratedColumn<int> get harga =>
      $composableBuilder(column: $table.harga, builder: (column) => column);
}

class $$BarangTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BarangTable,
    BarangData,
    $$BarangTableFilterComposer,
    $$BarangTableOrderingComposer,
    $$BarangTableAnnotationComposer,
    $$BarangTableCreateCompanionBuilder,
    $$BarangTableUpdateCompanionBuilder,
    (BarangData, BaseReferences<_$AppDatabase, $BarangTable, BarangData>),
    BarangData,
    PrefetchHooks Function()> {
  $$BarangTableTableManager(_$AppDatabase db, $BarangTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BarangTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BarangTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BarangTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> namaBarang = const Value.absent(),
            Value<int> kategoriId = const Value.absent(),
            Value<int> stok = const Value.absent(),
            Value<String> kelompokBarang = const Value.absent(),
            Value<int> harga = const Value.absent(),
          }) =>
              BarangCompanion(
            id: id,
            namaBarang: namaBarang,
            kategoriId: kategoriId,
            stok: stok,
            kelompokBarang: kelompokBarang,
            harga: harga,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String namaBarang,
            required int kategoriId,
            required int stok,
            required String kelompokBarang,
            required int harga,
          }) =>
              BarangCompanion.insert(
            id: id,
            namaBarang: namaBarang,
            kategoriId: kategoriId,
            stok: stok,
            kelompokBarang: kelompokBarang,
            harga: harga,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BarangTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BarangTable,
    BarangData,
    $$BarangTableFilterComposer,
    $$BarangTableOrderingComposer,
    $$BarangTableAnnotationComposer,
    $$BarangTableCreateCompanionBuilder,
    $$BarangTableUpdateCompanionBuilder,
    (BarangData, BaseReferences<_$AppDatabase, $BarangTable, BarangData>),
    BarangData,
    PrefetchHooks Function()>;
typedef $$KategoriTableCreateCompanionBuilder = KategoriCompanion Function({
  Value<int> id,
  required String namaKategori,
});
typedef $$KategoriTableUpdateCompanionBuilder = KategoriCompanion Function({
  Value<int> id,
  Value<String> namaKategori,
});

class $$KategoriTableFilterComposer
    extends Composer<_$AppDatabase, $KategoriTable> {
  $$KategoriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get namaKategori => $composableBuilder(
      column: $table.namaKategori, builder: (column) => ColumnFilters(column));
}

class $$KategoriTableOrderingComposer
    extends Composer<_$AppDatabase, $KategoriTable> {
  $$KategoriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get namaKategori => $composableBuilder(
      column: $table.namaKategori,
      builder: (column) => ColumnOrderings(column));
}

class $$KategoriTableAnnotationComposer
    extends Composer<_$AppDatabase, $KategoriTable> {
  $$KategoriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get namaKategori => $composableBuilder(
      column: $table.namaKategori, builder: (column) => column);
}

class $$KategoriTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KategoriTable,
    KategoriData,
    $$KategoriTableFilterComposer,
    $$KategoriTableOrderingComposer,
    $$KategoriTableAnnotationComposer,
    $$KategoriTableCreateCompanionBuilder,
    $$KategoriTableUpdateCompanionBuilder,
    (KategoriData, BaseReferences<_$AppDatabase, $KategoriTable, KategoriData>),
    KategoriData,
    PrefetchHooks Function()> {
  $$KategoriTableTableManager(_$AppDatabase db, $KategoriTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KategoriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KategoriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KategoriTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> namaKategori = const Value.absent(),
          }) =>
              KategoriCompanion(
            id: id,
            namaKategori: namaKategori,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String namaKategori,
          }) =>
              KategoriCompanion.insert(
            id: id,
            namaKategori: namaKategori,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KategoriTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KategoriTable,
    KategoriData,
    $$KategoriTableFilterComposer,
    $$KategoriTableOrderingComposer,
    $$KategoriTableAnnotationComposer,
    $$KategoriTableCreateCompanionBuilder,
    $$KategoriTableUpdateCompanionBuilder,
    (KategoriData, BaseReferences<_$AppDatabase, $KategoriTable, KategoriData>),
    KategoriData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BarangTableTableManager get barang =>
      $$BarangTableTableManager(_db, _db.barang);
  $$KategoriTableTableManager get kategori =>
      $$KategoriTableTableManager(_db, _db.kategori);
}
