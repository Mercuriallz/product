import 'package:equatable/equatable.dart';

class KategoriModel extends Equatable {
  final int id;
  final String namaKategori;

  const KategoriModel({
    required this.id,
    required this.namaKategori,
  });

  @override
  List<Object?> get props => [id, namaKategori];
}