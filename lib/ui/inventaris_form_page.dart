import 'package:flutter/material.dart';
import '../bloc/inventaris_bloc.dart';
import '../model/inventaris.dart';

class InventarisFormPage extends StatefulWidget {
  final Inventaris? inventaris;

  const InventarisFormPage({super.key, this.inventaris});

  @override
  State<InventarisFormPage> createState() => _InventarisFormPageState();
}

class _InventarisFormPageState extends State<InventarisFormPage> {
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _jumlahController = TextEditingController();
  final _tanggalController = TextEditingController();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    if (widget.inventaris != null) {
      _namaController.text = widget.inventaris!.nama ?? '';
      _hargaController.text = widget.inventaris!.harga?.toString() ?? '';
      _jumlahController.text = widget.inventaris!.jumlah?.toString() ?? '';
      _tanggalController.text = widget.inventaris!.tanggalMasuk ?? '';
    }
  }

  // ==========================
  // SAVE DATA
  // ==========================
  Future<void> _save() async {
    setState(() => _loading = true);

    final data = Inventaris(
      id: widget.inventaris?.id,
      nama: _namaController.text,
      harga: int.tryParse(_hargaController.text) ?? 0,
      jumlah: int.tryParse(_jumlahController.text) ?? 0,
      tanggalMasuk: _tanggalController.text,
    );

    bool ok = widget.inventaris == null
        ? await InventarisBloc.addInventaris(data: data)
        : await InventarisBloc.updateInventaris(data: data);

    setState(() => _loading = false);

    if (!mounted) return;
    if (ok) {
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Gagal"),
          content: const Text("Simpan data gagal"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  // ==========================
  // DATE PICKER
  // ==========================
  Future<void> _pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Colors.purple,
              onPrimary: Colors.white,
              surface: Colors.grey,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formatted =
          "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      setState(() {
        _tanggalController.text = formatted;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.inventaris != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEdit ? "Edit Inventaris Abimart" : "Tambah Inventaris Abimart",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _namaController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Nama Barang"),
              ),
              TextField(
                controller: _hargaController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Harga"),
              ),
              TextField(
                controller: _jumlahController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Jumlah"),
              ),

              // ==========================
              // DATE PICKER FIELD
              // ==========================
              TextField(
                controller: _tanggalController,
                readOnly: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(labelText: "Tanggal Masuk"),
                onTap: _pickDate,
              ),

              const SizedBox(height: 24),

              _loading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _save,
                      child: const Text("SIMPAN"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
