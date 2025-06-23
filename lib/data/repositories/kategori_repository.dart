// lib/data/repositories/kategori_repository.dart
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
}