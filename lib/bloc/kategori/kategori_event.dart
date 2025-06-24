// lib/bloc/kategori/kategori_event.dart
import 'package:equatable/equatable.dart';
import '../../data/models/kategori_model.dart';

abstract class KategoriEvent extends Equatable {
  const KategoriEvent();

  @override
  List<Object> get props => [];
}

class LoadKategori extends KategoriEvent {}

class AddKategori extends KategoriEvent {
  final KategoriModel kategori;

  const AddKategori(this.kategori);

  @override
  List<Object> get props => [kategori];
}

class UpdateKategori extends KategoriEvent {
  final KategoriModel kategori;

  const UpdateKategori(this.kategori);

  @override
  List<Object> get props => [kategori];
}

class DeleteKategori extends KategoriEvent {
  final int id;

  const DeleteKategori(this.id);

  @override
  List<Object> get props => [id];
}