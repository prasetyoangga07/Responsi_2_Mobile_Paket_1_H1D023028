class Inventaris {
  String? id;
  String? nama;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;

  Inventaris({this.id, this.nama, this.harga, this.jumlah, this.tanggalMasuk});

  Inventaris.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    nama = json['nama'];
    harga = int.tryParse(json['harga'].toString());
    jumlah = int.tryParse(json['jumlah'].toString());
    tanggalMasuk = json['tanggal_masuk'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'tanggal_masuk': tanggalMasuk,
    };
  }
}
