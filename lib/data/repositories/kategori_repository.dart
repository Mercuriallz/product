// lib/data/repositories/kategori_repository.dart
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/kategori_model.dart';
class KategoriRepository {
  final AppDatabase _database;

  KategoriRepository(this._database);

  Future<List<KategoriModel>> getAllKategori() async {
    final result = await _database.select(_database.kategori).get();
    return result.map((row) => KategoriModel(
      id: row.id,
      namaKategori: row.namaKategori,
    )).toList();
  }

  Future<void> insertKategori(KategoriModel kategori) async {
    await _database.into(_database.kategori).insert(
      KategoriCompanion.insert(
        namaKategori: kategori.namaKategori,
      ),
    );
  }

  Future<void> updateKategori(KategoriModel kategori) async {
    await (_database.update(_database.kategori)
          ..where((t) => t.id.equals(kategori.id)))
        .write(
          KategoriCompanion(
            namaKategori: Value(kategori.namaKategori),
          ),
        );
  }

  Future<void> deleteKategori(int id) async {
    await (_database.delete(_database.kategori)..where((t) => t.id.equals(id))).go();
  }
}