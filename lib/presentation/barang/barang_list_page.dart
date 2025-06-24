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
  final List<int> _selectedItems = [];
  bool _isSelecting = false;

  @override
  void initState() {
    super.initState();
    context.read<BarangBloc>().add(LoadBarang());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSelecting 
            ? Text('${_selectedItems.length} Selected')
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
              _isSelecting = false;
              _selectedItems.clear();
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
      floatingActionButton: _isSelecting
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddBarangPage(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
    );
  }

  List<Widget> _buildAppBarActions() {
    if (_isSelecting) {
      return [
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            if (_selectedItems.isNotEmpty) {
              _showDeleteConfirmationDialog();
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() {
              _isSelecting = false;
              _selectedItems.clear();
            });
          },
        ),
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            },
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
              _isSelecting = true;
              _toggleItemSelection(barang.id!);
            });
          },
          onTap: () {
            if (_isSelecting) {
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
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: _selectedItems.contains(barang.id)
                  ? Colors.blue
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
             
            ),
            child: ListTile(
              leading: _isSelecting
                  ? Checkbox(
                      value: _selectedItems.contains(barang.id),
                      onChanged: (value) {
                        setState(() {
                          _toggleItemSelection(barang.id!);
                        });
                      },
                    )
                  : Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.inventory_2, color: Colors.blue),
                    ),
              title: Text(barang.namaBarang),
              subtitle: Text('Stok: ${barang.stok}'),
              trailing: Text(
                _formatCurrency(barang.harga),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _toggleItemSelection(int id) {
    if (_selectedItems.contains(id)) {
      _selectedItems.remove(id);
      if (_selectedItems.isEmpty) {
        setState(() {
          _isSelecting = false;
        });
      }
    } else {
      _selectedItems.add(id);
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Barang'),
        content: Text('Yakin ingin menghapus ${_selectedItems.length} barang?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              context.read<BarangBloc>().add(DeleteMultipleBarang(_selectedItems));
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