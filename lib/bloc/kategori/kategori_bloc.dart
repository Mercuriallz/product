// lib/bloc/kategori/kategori_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_product/data/repositories/kategori_repository.dart';
import '../kategori/kategori_event.dart';
import '../kategori/kategori_state.dart';

class KategoriBloc extends Bloc<KategoriEvent, KategoriState> {
  final KategoriRepository kategoriRepository;

  KategoriBloc({required this.kategoriRepository}) : super(KategoriInitial()) {
    on<LoadKategori>(_onLoadKategori);
    on<AddKategori>(_onAddKategori);
    on<UpdateKategori>(_onUpdateKategori);
    on<DeleteKategori>(_onDeleteKategori);
  }

  Future<void> _onLoadKategori(LoadKategori event, Emitter<KategoriState> emit) async {
    emit(KategoriLoading());
    try {
      final kategoriList = await kategoriRepository.getAllKategori();
      emit(KategoriLoaded(kategoriList));
    } catch (e) {
      emit(KategoriError('Failed to load kategori: $e'));
    }
  }

  Future<void> _onAddKategori(AddKategori event, Emitter<KategoriState> emit) async {
    try {
      await kategoriRepository.insertKategori(event.kategori);
      emit(KategoriOperationSuccess('Kategori added successfully'));
      add(LoadKategori());
    } catch (e) {
      emit(KategoriError('Failed to add kategori: $e'));
    }
  }

  Future<void> _onUpdateKategori(UpdateKategori event, Emitter<KategoriState> emit) async {
    try {
      await kategoriRepository.updateKategori(event.kategori);
      emit(KategoriOperationSuccess('Kategori updated successfully'));
      add(LoadKategori());
    } catch (e) {
      emit(KategoriError('Failed to update kategori: $e'));
    }
  }

  Future<void> _onDeleteKategori(DeleteKategori event, Emitter<KategoriState> emit) async {
    try {
      await kategoriRepository.deleteKategori(event.id);
      emit(KategoriOperationSuccess('Kategori deleted successfully'));
      add(LoadKategori());
    } catch (e) {
      emit(KategoriError('Failed to delete kategori: $e'));
    }
  }
}