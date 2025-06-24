import 'package:equatable/equatable.dart';
import '../../data/models/kategori_model.dart';

abstract class KategoriState extends Equatable {
  const KategoriState();

  @override
  List<Object> get props => [];
}

class KategoriInitial extends KategoriState {}

class KategoriLoading extends KategoriState {}

class KategoriLoaded extends KategoriState {
  final List<KategoriModel> kategoriList;

  const KategoriLoaded(this.kategoriList);

  @override
  List<Object> get props => [kategoriList];
}

class KategoriError extends KategoriState {
  final String message;

  const KategoriError(this.message);

  @override
  List<Object> get props => [message];
}

class KategoriOperationSuccess extends KategoriState {
  final String message;

  const KategoriOperationSuccess(this.message);

  @override
  List<Object> get props => [message];
}