import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test_product/data/models/barang_model.dart';
import 'package:test_product/presentation/barang/add_barang_page.dart';
import 'package:test_product/presentation/barang/barang_detail_bottom.dart';
import '../../bloc/barang/barang_bloc.dart';
import '../../bloc/barang/barang_event.dart';
import '../../bloc/barang/barang_state.dart';

class BarangListPage extends StatefulWidget {
  const BarangListPage({super.key});

  @override
  State<BarangListPage> createState() => _BarangListPageState();
}

class _BarangListPageState extends State<BarangListPage> {
  final List<int> selectedItems = [];
  bool isSelecting = false;

  @override
  void initState() {
    super.initState();
    context.read<BarangBloc>().add(LoadBarang());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSelecting
            ? Text('${selectedItems.length} Selected')
            : const Text('Daftar Barang'),
        actions: _buildAppBarActions(),
      ),
      body: BlocConsumer<BarangBloc, BarangState>(
        listener: (context, state) {
          if (state is BarangOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            setState(() {
              isSelecting = false;
              selectedItems.clear();
            });
          } else if (state is BarangError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is BarangLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BarangLoaded) {
            return _buildBarangList(state.barangList);
          } else if (state is BarangError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No data available'));
        },
      ),
      bottomNavigationBar: isSelecting
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddBarangPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Tambah Barang"),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (isSelecting) {
      return [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            if (selectedItems.isNotEmpty) {
              _showDeleteConfirmationDialog();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              isSelecting = false;
              selectedItems.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
      ];
    }
  }

  Widget _buildBarangList(List<BarangModel> barangList) {
    return ListView.builder(
      itemCount: barangList.length,
      itemBuilder: (context, index) {
        final barang = barangList[index];
        return InkWell(
          onLongPress: () {
            setState(() {
              isSelecting = true;
              _toggleItemSelection(barang.id!);
            });
          },
          onTap: () {
            if (isSelecting) {
              setState(() {
                _toggleItemSelection(barang.id!);
              });
            } else {
              showModalBottomSheet(
                context: context,
                builder: (context) => BarangDetailBottomSheet(barang: barang),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: selectedItems.contains(barang.id)
                  ? Colors.white
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      barang.namaBarang,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Stok: ${barang.stok}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Kategori: ${barang.kategoriId}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      _formatCurrency(barang.harga),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Kelompok: ${barang.kelompokBarang}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                if (isSelecting)
                  Checkbox(
                    value: selectedItems.contains(barang.id),
                    onChanged: (value) {
                      setState(() {
                        _toggleItemSelection(barang.id!);
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _toggleItemSelection(int id) {
    if (selectedItems.contains(id)) {
      selectedItems.remove(id);
      if (selectedItems.isEmpty) {
        setState(() {
          isSelecting = false;
        });
      }
    } else {
      selectedItems.add(id);
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin ingin menghapus ${selectedItems.length} barang?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context
                  .read<BarangBloc>()
                  .add(DeleteMultipleBarang(selectedItems));
              Navigator.pop(context);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(int amount) {
    final format = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return format.format(amount);
  }
}
