import 'package:equatable/equatable.dart';
import '../../data/models/barang_model.dart';

abstract class BarangEvent extends Equatable {
  const BarangEvent();

  @override
  List<Object> get props => [];
}

class LoadBarang extends BarangEvent {}

class AddBarang extends BarangEvent {
  final BarangModel barang;

  const AddBarang(this.barang);

  @override
  List<Object> get props => [barang];
}

class UpdateBarang extends BarangEvent {
  final BarangModel barang;

  const UpdateBarang(this.barang);

  @override
  List<Object> get props => [barang];
}

class DeleteBarang extends BarangEvent {
  final int id;

  const DeleteBarang(this.id);

  @override
  List<Object> get props => [id];
}

class DeleteMultipleBarang extends BarangEvent {
  final List<int> ids;

  const DeleteMultipleBarang(this.ids);

  @override
  List<Object> get props => [ids];
}