// lib/ui/barang/add_barang_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_product/bloc/kategori/kategori_bloc.dart';
import 'package:test_product/bloc/kategori/kategori_event.dart';
import 'package:test_product/bloc/kategori/kategori_state.dart';
import 'package:test_product/presentation/widgets/custom_dropdown.dart';
import 'package:test_product/presentation/widgets/rupiah_converter.dart';
import '../../bloc/barang/barang_bloc.dart';
import '../../bloc/barang/barang_event.dart';

import '../../data/models/barang_model.dart';


class AddBarangPage extends StatefulWidget {
  const AddBarangPage({super.key});

  @override
  State<AddBarangPage> createState() => _AddBarangPageState();
}

class _AddBarangPageState extends State<AddBarangPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaBarangController = TextEditingController();
  final _stokController = TextEditingController();
  final _hargaController = TextEditingController();
  int? _selectedKategoriId;
  String? _selectedKelompok;

  final List<String> _kelompokOptions = [
    'Kelompok 1',
    'Kelompok 2',
    'Kelompok 3',
    'Kelompok 4',
  ];

  @override
  void initState() {
    super.initState();
    context.read<KategoriBloc>().add(LoadKategori());
    _hargaController.addListener(_formatHarga);
  }

  @override
  void dispose() {
    _namaBarangController.dispose();
    _stokController.dispose();
    _hargaController.removeListener(_formatHarga);
    _hargaController.dispose();
    super.dispose();
  }

  void _formatHarga() {
    final text = _hargaController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.isNotEmpty) {
      final value = int.parse(text);
      _hargaController.value = _hargaController.value.copyWith(
        text: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(value),
        selection: TextSelection.collapsed(
          offset: NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(value).length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Barang'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveBarang,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaBarangController,
                decoration: const InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama barang harus diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              BlocBuilder<KategoriBloc, KategoriState>(
                builder: (context, state) {
                  if (state is KategoriLoaded) {
                    return CustomDropdown<int>(
                      label: 'Kategori',
                      value: _selectedKategoriId,
                      items: state.kategoriList
                          .map((kategori) => DropdownMenuItem<int>(
                                value: kategori.id,
                                child: Text(kategori.namaKategori),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedKategoriId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Pilih kategori';
                        }
                        return null;
                      },
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(
                  labelText: 'Stok',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok harus diisi';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomDropdown<String>(
                label: 'Kelompok Barang',
                value: _selectedKelompok,
                items: _kelompokOptions
                    .map((kelompok) => DropdownMenuItem<String>(
                          value: kelompok,
                          child: Text(kelompok),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedKelompok = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Pilih kelompok barang';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [RupiahInputFormatter()],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga harus diisi';
                  }
                  final numericValue = value.replaceAll(RegExp(r'[^\d]'), '');
                  if (numericValue.isEmpty || int.tryParse(numericValue) == null) {
                    return 'Masukkan harga yang valid';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveBarang() {
    if (_formKey.currentState!.validate()) {
      final harga = int.parse(_hargaController.text.replaceAll(RegExp(r'[^\d]'), ''));
      
      final barang = BarangModel(
        namaBarang: _namaBarangController.text,
        kategoriId: _selectedKategoriId!,
        stok: int.parse(_stokController.text),
        kelompokBarang: _selectedKelompok!,
        harga: harga,
      );

      context.read<BarangBloc>().add(AddBarang(barang));
      Navigator.pop(context);
    }
  }
}