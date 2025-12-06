# 📦 INVENTARIS KOMPUTER ABIMART  
Aplikasi Responsi 2 Mobile – Flutter + API CodeIgniter 4  
Nama : **Prasetyo Angga Permana**  
NIM : **H1D023028**  
Shift KRS : **A**  
Shift Baru : **A**  

---

## 📘 DESKRIPSI APLIKASI
Aplikasi **Inventaris Komputer Abimart** adalah aplikasi mobile berbasis Flutter yang terhubung dengan REST API CodeIgniter 4 untuk melakukan:

- Login & Registrasi User  
- CRUD Data Inventaris (Create, Read, Update, Delete)  
- Penyimpanan Token Login  
- Menampilkan daftar inventaris komputer Abimart  

Aplikasi ini dibangun untuk memenuhi **Responsi 2 Mobile Programming**.

---

# 🪧 DEMO APLIKASI


https://github.com/user-attachments/assets/663f6239-1a3c-4c2e-a91c-b9abb5796d36

---


## 🏗 TEKNOLOGI YANG DIGUNAKAN
### **Frontend**
- Flutter
- Dart
- Material Design UI
- HTTP Package (REST API)
- Shared Preferences (Menyimpan Token Login)

### **Backend**
- CodeIgniter 4
- MySQL Database
- RESTful API Struktur JSON

---

## 🔐 1. LOGIN
User memasukkan email & password kemudian klik **Login**.  
Aplikasi akan mengirim request ke API:

```json
POST /login
{
  "email": "pras@gmail.com",
  "password": "123456"
}
```
Jika berhasil → Token & data user disimpan di aplikasi.
<img width="496" height="816" alt="Screenshot 2025-12-06 072124" src="https://github.com/user-attachments/assets/4496d645-bba0-4f03-8d45-4e9f7d2c23f9" />

## Kode Login
```LoginBloc.login(
  email: _emailController.text,
  password: _passwordController.text,
).then((value) async {
  if (value.status == true) {
    await UserInfo().setToken(value.token!);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const InventarisPage()),
    );
  } else {
    showDialog(
      context: context,
      builder: (_) => const WarningDialog(description: "Login gagal"),
    );
  }
});
```

# 📝 2. REGISTRASI
Form berisi:
✔ Nama
✔ Email
✔ Password

Request ke API CodeIgniter:
```
POST /registrasi
{
  "nama": "pras",
  "email": "pras@gmail.com",
  "password": "123456"
}
```
<img width="498" height="819" alt="Screenshot 2025-12-06 072319" src="https://github.com/user-attachments/assets/d22b0dc0-bb4b-4f8e-a358-2556fd5320d5" />

## Kode Registrasi :
```
RegistrasiBloc.registrasi(
  nama: _namaController.text,
  email: _emailController.text,
  password: _passwordController.text,
).then((value) {
  showDialog(
    context: context,
    builder: (_) => const SuccessDialog(
      description: "Registrasi berhasil, silahkan login",
    ),
  );
});
```

# 📄 3. LIST INVENTARIS
Setelah login, user diarahkan ke halaman daftar inventaris Abimart.
Semua data diambil dari API :
``GET /inventaris``


<img width="498" height="847" alt="Screenshot 2025-12-06 072450" src="https://github.com/user-attachments/assets/abf47363-fb24-421f-ad01-ebfb80362771" />


## Kode Get Inventaris
```
FutureBuilder(
  future: InventarisBloc.getInventaris(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ListInventaris(list: snapshot.data!);
    }
    return const Center(child: CircularProgressIndicator());
  },
)
```

# ➕ 4. TAMBAH INVENTARIS
User memasukkan:
- Nama barang
- Harga
- Jumlah
- Tanggal masuk (DatePicker)
<img width="495" height="842" alt="Screenshot 2025-12-06 072610" src="https://github.com/user-attachments/assets/3415101e-db31-4f0c-80d1-ba4cc6663d50" />

## Kode Simpan 
```
InventarisBloc.addInventaris(data: Inventaris(
  nama: _namaController.text,
  harga: int.parse(_hargaController.text),
  jumlah: int.parse(_jumlahController.text),
  tanggalMasuk: _tanggalController.text,
));
```

# ✏️ 5. EDIT INVENTARIS
<img width="497" height="854" alt="Screenshot 2025-12-06 072806" src="https://github.com/user-attachments/assets/b982e9c8-8e96-475e-b49a-f24e7183135f" />

## Kode Update :
```
InventarisBloc.updateInventaris(data: Inventaris(
  id: widget.inventaris!.id,
  nama: _namaController.text,
  harga: int.parse(_hargaController.text),
  jumlah: int.parse(_jumlahController.text),
  tanggalMasuk: _tanggalController.text,
));
```

# 🗑 6. HAPUS INVENTARIS
  Aplikasi menampilkan popup konfirmasi sebelum data dihapus.
  <img width="491" height="848" alt="Screenshot 2025-12-06 072942" src="https://github.com/user-attachments/assets/ee792356-b7ec-430f-bfc9-7e28b91d67d6" />
## Kode Hapus :
```
InventarisBloc.deleteInventaris(id: item.id).then((value) {
  if (value) setState(() {});
});
```
# 🚪 7. LOGOUT
Token login dihapus & user kembali ke halaman login.

## Kode Logout :
```
await UserInfo().logout();
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_) => const LoginPage()),
  (route) => false,
);
```

# 🔧 8. SETTING API URL

``File: lib/helpers/api_url.dart``
```
class ApiUrl {
  static const String baseUrl = "http://192.168.xx.15:8080";

  static const String login = "$baseUrl/login";
  static const String registrasi = "$baseUrl/registrasi";

  static const String inventaris = "$baseUrl/inventaris";
  static String updateInventaris(int id) => "$baseUrl/inventaris/$id";
  static String deleteInventaris(int id) => "$baseUrl/inventaris/$id";
}
```
