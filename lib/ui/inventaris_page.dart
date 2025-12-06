import 'package:flutter/material.dart';
import '../bloc/inventaris_bloc.dart';
import '../model/inventaris.dart';
import 'inventaris_form_page.dart';
import '../helpers/user_info.dart';
import 'login_page.dart';

class InventarisPage extends StatefulWidget {
  const InventarisPage({super.key});

  @override
  State<InventarisPage> createState() => _InventarisPageState();
}

class _InventarisPageState extends State<InventarisPage> {
  Future<List<Inventaris>>? _future;

  @override
  void initState() {
    super.initState();
    _future = InventarisBloc.getInventaris();
  }

  void _refresh() {
    setState(() {
      _future = InventarisBloc.getInventaris();
    });
  }

  void _logout() async {
    await UserInfo().logout();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inventaris Komputer Abimart"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _refresh, icon: const Icon(Icons.refresh)),
          IconButton(onPressed: _logout, icon: const Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<List<Inventaris>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Data kosong", style: TextStyle(color: Colors.white)),
            );
          }
          final list = snapshot.data!;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, i) {
              final item = list[i];
              return Card(
                child: ListTile(
                  title: Text(item.nama ?? ''),
                  subtitle: Text(
                    "Harga: ${item.harga} | Jumlah: ${item.jumlah}\nTgl masuk: ${item.tanggalMasuk}",
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  InventarisFormPage(inventaris: item),
                            ),
                          );
                          _refresh();
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          final ok = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Hapus"),
                              content: const Text("Yakin hapus data ini?"),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text("Batal"),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text("Hapus"),
                                ),
                              ],
                            ),
                          );
                          if (ok == true) {
                            await InventarisBloc.deleteInventaris(
                              id: int.parse(item.id!),
                            );
                            _refresh();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const InventarisFormPage()),
          );
          _refresh();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
