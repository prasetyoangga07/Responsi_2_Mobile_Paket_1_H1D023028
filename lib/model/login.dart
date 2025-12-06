class Login {
  int? code;
  bool? status;
  String? token;
  String? userID;
  String? nama;
  String? email;

  Login({
    this.code,
    this.status,
    this.token,
    this.userID,
    this.nama,
    this.email,
  });

  Login.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    status = json["status"];

    // API KAMU MENGIRIM DATA SEPERTI INI:
    // data: { id, nama, email }
    if (json["data"] != null) {
      token = ""; // API tidak mengirim token, isi kosong saja

      userID = json["data"]["id"].toString();
      nama = json["data"]["nama"];
      email = json["data"]["email"];
    }
  }
}
