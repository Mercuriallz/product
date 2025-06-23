import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../models/barang_model.dart';


class BarangRepository {
  final AppDatabase _database;

  BarangRepository(this._database);

  Future<List<BarangModel>> getAllBarang() async {
    final query = _database.select(_database.barang)
      ..orderBy([(t) => OrderingTerm(expression: t.namaBarang)]);
    final result = await query.get();
    return result.map((row) => BarangModel(
      id: row.id,
      namaBarang: row.namaBarang,
      kategoriId: row.kategoriId,
      stok: row.stok,
      kelompokBarang: row.kelompokBarang,
      harga: row.harga,
    )).toList();
  }

  Future<void> insertBarang(BarangModel barang) async {
    await _database.into(_database.barang).insert(
      BarangCompanion.insert(
        namaBarang: barang.namaBarang,
        kategoriId: barang.kategoriId,
        stok: barang.stok,
        kelompokBarang: barang.kelompokBarang,
        harga: barang.harga,
      ),
    );
  }

  Future<void> updateBarang(BarangModel barang) async {
    await (_database.update(_database.barang)
          ..where((t) => t.id.equals(barang.id!)))
        .write(
          BarangCompanion(
            namaBarang: Value(barang.namaBarang),
            kategoriId: Value(barang.kategoriId),
            stok: Value(barang.stok),
            kelompokBarang: Value(barang.kelompokBarang),
            harga: Value(barang.harga),
          ),
        );
  }

  Future<void> deleteBarang(int id) async {
    await (_database.delete(_database.barang)..where((t) => t.id.equals(id))).go();
  }

  Future<void> deleteMultipleBarang(List<int> ids) async {
    await (_database.delete(_database.barang)..where((t) => t.id.isIn(ids))).go();
  }
}