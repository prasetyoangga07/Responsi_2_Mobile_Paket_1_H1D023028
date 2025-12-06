class Registrasi {
  int? code;
  bool? status;
  String? message;

  Registrasi.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['data'].toString();
  }
}
