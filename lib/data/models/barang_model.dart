import 'package:equatable/equatable.dart';

class BarangModel extends Equatable {
  final int? id;
  final String namaBarang;
  final int kategoriId;
  final int stok;
  final String kelompokBarang;
  final int harga;

  const BarangModel({
    this.id,
    required this.namaBarang,
    required this.kategoriId,
    required this.stok,
    required this.kelompokBarang,
    required this.harga,
  });

  @override
  List<Object?> get props => [id, namaBarang, kategoriId, stok, kelompokBarang, harga];
}