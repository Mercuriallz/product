import 'package:equatable/equatable.dart';
import '../../data/models/barang_model.dart';

abstract class BarangState extends Equatable {
  const BarangState();

  @override
  List<Object> get props => [];
}

class BarangInitial extends BarangState {}

class BarangLoading extends BarangState {}

class BarangLoaded extends BarangState {
  final List<BarangModel> barangList;

  const BarangLoaded(this.barangList);

  @override
  List<Object> get props => [barangList];
}

class BarangError extends BarangState {
  final String message;

  const BarangError(this.message);

  @override
  List<Object> get props => [message];
}

class BarangOperationSuccess extends BarangState {
  final String message;

  const BarangOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}