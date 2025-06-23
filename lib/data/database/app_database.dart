import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:test_product/data/database/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Barang, Kategori])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<void> insertInitialKategori() async {
    final existing = await select(kategori).get();
    if (existing.isEmpty) {
      await batch((batch) {
        batch.insertAll(kategori, [
          KategoriCompanion.insert(namaKategori: 'Elektronik'),
          KategoriCompanion.insert(namaKategori: 'Pakaian'),
          KategoriCompanion.insert(namaKategori: 'Makanan'),
          KategoriCompanion.insert(namaKategori: 'Minuman'),
          KategoriCompanion.insert(namaKategori: 'Alat Tulis'),
        ]);
      });
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}