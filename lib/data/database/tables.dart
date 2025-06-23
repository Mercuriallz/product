import 'package:drift/drift.dart';


class Barang extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaBarang => text()();
  IntColumn get kategoriId => integer()();
  IntColumn get stok => integer()();
  TextColumn get kelompokBarang => text()();
  IntColumn get harga => integer()();
}

class Kategori extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get namaKategori => text()();
}