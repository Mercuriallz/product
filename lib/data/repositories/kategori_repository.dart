// lib/data/repositories/kategori_repository.dart
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/kategori_model.dart';
class KategoriRepository {
  final AppDatabase database;

  KategoriRepository(this.database);

  Future<List<KategoriModel>> getAllKategori() async {
    final result = await database.select(database.kategori).get();
    return result.map((row) => KategoriModel(
      id: row.id,
      namaKategori: row.namaKategori,
    )).toList();
  }

  Future<void> insertKategori(KategoriModel kategori) async {
    await database.into(database.kategori).insert(
      KategoriCompanion.insert(
        namaKategori: kategori.namaKategori,
      ),
    );
  }

  Future<void> updateKategori(KategoriModel kategori) async {
    await (database.update(database.kategori)
          ..where((t) => t.id.equals(kategori.id)))
        .write(
          KategoriCompanion(
            namaKategori: Value(kategori.namaKategori),
          ),
        );
  }

  Future<void> deleteKategori(int id) async {
    await (database.delete(database.kategori)..where((t) => t.id.equals(id))).go();
  }
}