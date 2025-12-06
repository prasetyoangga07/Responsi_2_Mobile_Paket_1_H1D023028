import 'dart:convert';

import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../model/inventaris.dart';

class InventarisBloc {
  static Future<List<Inventaris>> getInventaris() async {
    String apiUrl = ApiUrl.listInventaris;
    var response = await Api().get(apiUrl);
    List<dynamic> list = response['data'];
    return list.map((e) => Inventaris.fromJson(e)).toList();
  }

  static Future<bool> addInventaris({required Inventaris data}) async {
    String apiUrl = ApiUrl.createInventaris;
    var body = {
      "nama": data.nama,
      "harga": data.harga.toString(),
      "jumlah": data.jumlah.toString(),
      "tanggal_masuk": data.tanggalMasuk,
    };
    var response = await Api().post(apiUrl, body);
    return response['status'] == true;
  }

  static Future<bool> updateInventaris({required Inventaris data}) async {
    String apiUrl = ApiUrl.updateInventaris(int.parse(data.id!));
    var body = {
      "nama": data.nama,
      "harga": data.harga.toString(),
      "jumlah": data.jumlah.toString(),
      "tanggal_masuk": data.tanggalMasuk,
    };
    var response = await Api().put(apiUrl, jsonEncode(body));
    return response['status'] == true;
  }

  static Future<bool> deleteInventaris({required int id}) async {
    String apiUrl = ApiUrl.deleteInventaris(id);
    var response = await Api().delete(apiUrl);
    return response['status'] == true;
  }
}
