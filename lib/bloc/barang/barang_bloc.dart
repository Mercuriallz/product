// lib/bloc/barang/barang_bloc.dart
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/barang_repository.dart';
import 'barang_event.dart';
import 'barang_state.dart';

class BarangBloc extends Bloc<BarangEvent, BarangState> {
  final BarangRepository barangRepository;

  BarangBloc({required this.barangRepository}) : super(BarangInitial()) {
    on<LoadBarang>(_onLoadBarang);
    on<AddBarang>(_onAddBarang);
    on<UpdateBarang>(_onUpdateBarang);
    on<DeleteBarang>(_onDeleteBarang);
    on<DeleteMultipleBarang>(_onDeleteMultipleBarang);
  }

  Future<void> _onLoadBarang(LoadBarang event, Emitter<BarangState> emit) async {
    emit(BarangLoading());
    try {
      final barangList = await barangRepository.getAllBarang();
      emit(BarangLoaded(barangList));
    } catch (e) {
      emit(BarangError('Failed to load barang: $e'));
    }
  }

  Future<void> _onAddBarang(AddBarang event, Emitter<BarangState> emit) async {
    try {
      await barangRepository.insertBarang(event.barang);
      emit(BarangOperationSuccess('Barang added successfully'));
      add(LoadBarang());
    } catch (e) {
      emit(BarangError('Failed to add barang: $e'));
    }
  }

  Future<void> _onUpdateBarang(UpdateBarang event, Emitter<BarangState> emit) async {
    try {
      await barangRepository.updateBarang(event.barang);
      emit(BarangOperationSuccess('Barang updated successfully'));
      add(LoadBarang());
    } catch (e) {
      emit(BarangError('Failed to update barang: $e'));
    }
  }

  Future<void> _onDeleteBarang(DeleteBarang event, Emitter<BarangState> emit) async {
    try {
      await barangRepository.deleteBarang(event.id);
      emit(BarangOperationSuccess('Barang deleted successfully'));
      add(LoadBarang());
    } catch (e) {
      emit(BarangError('Failed to delete barang: $e'));
    }
  }

  Future<void> _onDeleteMultipleBarang(DeleteMultipleBarang event, Emitter<BarangState> emit) async {
    try {
      await barangRepository.deleteMultipleBarang(event.ids);
      emit(BarangOperationSuccess('Selected barang deleted successfully'));
      add(LoadBarang());
    } catch (e) {
      emit(BarangError('Failed to delete selected barang: $e'));
    }
  }
}