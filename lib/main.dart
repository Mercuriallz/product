import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_product/presentation/barang/barang_list_page.dart';
import 'data/database/app_database.dart';
import 'data/repositories/barang_repository.dart';
import 'data/repositories/kategori_repository.dart';
import 'bloc/barang/barang_bloc.dart';
import 'bloc/kategori/kategori_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = AppDatabase();
  await database.insertInitialKategori();

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;

  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BarangRepository>(
          create: (context) => BarangRepository(database),
        ),
        RepositoryProvider<KategoriRepository>(
          create: (context) => KategoriRepository(database),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => BarangBloc(
              barangRepository: context.read<BarangRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => KategoriBloc(
              kategoriRepository: context.read<KategoriRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Manajemen Barang',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const BarangListPage(),
        ),
      ),
    );
  }
}