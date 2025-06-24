import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_product/bloc/kategori/kategori_bloc.dart';
import 'package:test_product/bloc/kategori/kategori_event.dart';
import 'package:test_product/bloc/kategori/kategori_state.dart';
import 'package:test_product/presentation/widgets/custom_text_field.dart';
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
  final formKey = GlobalKey<FormState>();
  final namaBarangController = TextEditingController();
  final stokController = TextEditingController();
  final hargaController = TextEditingController();
  int? selectedKategoriId;
  String? selectedKelompok;
  bool isLoading = false;

  final List<String> kelompokOptions = [
    'Kelompok 1',
    'Kelompok 2',
    'Kelompok 3',
    'Kelompok 4',
  ];

  @override
  void initState() {
    super.initState();
    context.read<KategoriBloc>().add(LoadKategori());
    hargaController.addListener(_formatHarga);
  }

  @override
  void dispose() {
    namaBarangController.dispose();
    stokController.dispose();
    hargaController.removeListener(_formatHarga);
    hargaController.dispose();
    super.dispose();
  }

  void _formatHarga() {
    final text = hargaController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (text.isNotEmpty) {
      final value = int.parse(text);
      hargaController.value = hargaController.value.copyWith(
        text:
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(value),
        selection: TextSelection.collapsed(
          offset: NumberFormat.currency(
                  locale: 'id', symbol: 'Rp ', decimalDigits: 0)
              .format(value)
              .length,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        title: const Text(
          'Tambah Barang Baru',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: _calculateProgress(),
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Langkah ${_getCompletedSteps()} dari 5',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${(_calculateProgress() * 100).toInt()}% selesai',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Informasi Barang',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Lengkapi detail barang yang akan ditambahkan',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildFormField(
                      label: 'Nama Barang',
                      icon: Icons.shopping_bag_outlined,
                      child: CustomTextField(
                        controller: namaBarangController,
                        label: 'Nama Barang',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama barang harus diisi';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Kategori',
                      icon: Icons.category_outlined,
                      child: BlocBuilder<KategoriBloc, KategoriState>(
                        builder: (context, state) {
                          if (state is KategoriLoaded) {
                            return DropdownButtonFormField<int>(
                              value: selectedKategoriId,
                              decoration: _buildInputDecoration(
                                'Pilih kategori barang',
                                Icons.category_outlined,
                              ),
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
                            );
                          }
                          return Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: _buildFormField(
                            label: 'Stok',
                            icon: Icons.inventory_outlined,
                            child: CustomTextField(
                              controller: stokController,
                              label: "Stok",
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
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildFormField(
                            label: 'Kelompok',
                            icon: Icons.group_work_outlined,
                            child: DropdownButtonFormField<String>(
                              value: selectedKelompok,
                              decoration: _buildInputDecoration(
                                'Pilih kelompok',
                                Icons.group_work_outlined,
                              ),
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
                                  return 'Pilih kelompok';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildFormField(
                      label: 'Harga',
                      icon: Icons.attach_money_outlined,
                      child: CustomTextField(
                        icon: Icons.attach_money,
                        label: "Harga",
                        controller: hargaController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [RupiahInputFormatter()],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Harga harus diisi';
                          }
                          final numericValue =
                              value.replaceAll(RegExp(r'[^\d]'), '');
                          if (numericValue.isEmpty ||
                              int.tryParse(numericValue) == null) {
                            return 'Masukkan harga yang valid';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _saveBarang,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Simpan Barang',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }

  InputDecoration _buildInputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey[400],
        fontSize: 14,
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey[300]!),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }

  double _calculateProgress() {
    int completed = 0;
    if (namaBarangController.text.isNotEmpty) completed++;
    if (selectedKategoriId != null) completed++;
    if (stokController.text.isNotEmpty) completed++;
    if (selectedKelompok != null) completed++;
    if (hargaController.text.isNotEmpty) completed++;
    return completed / 5;
  }

  int _getCompletedSteps() {
    int completed = 0;
    if (namaBarangController.text.isNotEmpty) completed++;
    if (selectedKategoriId != null) completed++;
    if (stokController.text.isNotEmpty) completed++;
    if (selectedKelompok != null) completed++;
    if (hargaController.text.isNotEmpty) completed++;
    return completed;
  }

  void _saveBarang() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        final harga =
            int.parse(hargaController.text.replaceAll(RegExp(r'[^\d]'), ''));

        final barang = BarangModel(
          namaBarang: namaBarangController.text,
          kategoriId: selectedKategoriId!,
          stok: int.parse(stokController.text),
          kelompokBarang: selectedKelompok!,
          harga: harga,
        );

        context.read<BarangBloc>().add(AddBarang(barang));

        await Future.delayed(const Duration(milliseconds: 500));

        if (mounted) {
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Barang berhasil ditambahkan'),
                ],
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(Icons.error, color: Colors.white),
                  SizedBox(width: 12),
                  Text('Gagal menambahkan barang'),
                ],
              ),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }
}
