import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_product/bloc/kategori/kategori_bloc.dart';
import 'package:test_product/bloc/kategori/kategori_event.dart';
import 'package:test_product/bloc/kategori/kategori_state.dart';
import 'package:test_product/presentation/widgets/custom_dropdown.dart';
import 'package:test_product/presentation/widgets/custom_text_field.dart';
import 'package:test_product/presentation/widgets/rupiah_converter.dart';
import '../../../bloc/barang/barang_bloc.dart';
import '../../../bloc/barang/barang_event.dart';
import '../../../data/models/barang_model.dart';

class EditBarangPage extends StatefulWidget {
  final BarangModel barang;

  const EditBarangPage({super.key, required this.barang});

  @override
  State<EditBarangPage> createState() => _EditBarangPageState();
}

class _EditBarangPageState extends State<EditBarangPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController namaController;
  late TextEditingController kategoriController;
  late TextEditingController stokController;
  late TextEditingController kelompokController;
  late TextEditingController hargaController;

  String? selectedKelompok;

  int? selectedKategoriId;
  final List<String> kelompokOptions = [
    'Kelompok 1',
    'Kelompok 2',
    'Kelompok 3',
    'Kelompok 4',
  ];

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.barang.namaBarang);
    kategoriController =
        TextEditingController(text: widget.barang.kategoriId.toString());
    stokController = TextEditingController(text: widget.barang.stok.toString());
    kelompokController =
        TextEditingController(text: widget.barang.kelompokBarang);
    hargaController =
        TextEditingController(text: widget.barang.harga.toString());
    context.read<KategoriBloc>().add(LoadKategori());
  }

  @override
  void dispose() {
    namaController.dispose();
    kategoriController.dispose();
    stokController.dispose();
    kelompokController.dispose();
    hargaController.dispose();
    super.dispose();
  }

  void _submitEdit() {
    final harga =
        int.parse(hargaController.text.replaceAll(RegExp(r'[^\d]'), ''));
    if (_formKey.currentState!.validate()) {
      final updatedBarang = BarangModel(
        id: widget.barang.id,
        namaBarang: namaController.text,
        kategoriId: int.tryParse(kategoriController.text) ?? 0,
        stok: int.tryParse(stokController.text) ?? 0,
        kelompokBarang: kelompokController.text,
        harga: harga,
      );

      context.read<BarangBloc>().add(UpdateBarang(updatedBarang));
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  Widget _buildFormCard({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text(
          'Edit Barang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade600, Colors.blue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 32,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Edit Informasi Barang',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Perbarui data barang dengan informasi terbaru',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildFormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Informasi Dasar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      controller: namaController,
                      label: 'Nama Barang',
                      icon: Icons.inventory_2,
                      validator: (value) =>
                          value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                  ],
                ),
              ),
              _buildFormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kategori & Kelompok',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<KategoriBloc, KategoriState>(
                      builder: (context, state) {
                        if (state is KategoriLoaded) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                              color: Colors.grey.shade50,
                            ),
                            child: CustomDropdown<int>(
                              label: 'Kategori',
                              value: selectedKategoriId,
                              items: state.kategoriList
                                  .map((kategori) => DropdownMenuItem<int>(
                                        value: kategori.id,
                                        child: Text(kategori.namaKategori),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedKategoriId = value;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return 'Pilih kategori';
                                }
                                return null;
                              },
                            ),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.all(20),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                        color: Colors.grey.shade50,
                      ),
                      child: CustomDropdown<String>(
                        label: 'Kelompok Barang',
                        value: selectedKelompok,
                        items: kelompokOptions
                            .map((kelompok) => DropdownMenuItem<String>(
                                  value: kelompok,
                                  child: Text(kelompok),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedKelompok = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Pilih kelompok barang';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _buildFormCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stok & Harga',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            controller: stokController,
                            label: 'Stok',
                            icon: Icons.inventory,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            inputFormatters: [RupiahInputFormatter()],
                            controller: hargaController,
                            label: 'Harga',
                            icon: Icons.attach_money,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade600, Colors.green.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ElevatedButton(
                  onPressed: _submitEdit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    'Simpan Perubahan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
