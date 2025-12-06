import '../helpers/api.dart';
import '../helpers/api_url.dart';
import '../model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    final url = ApiUrl.login;

    final body = {"email": email, "password": password};

    final response = await Api().post(url, body);

    // 🔥 DEBUG DI SINI — UNTUK MELIHAT APA YANG DIKIRIM API
    print("==== LOGIN RESPONSE ====");
    print(response);

    return Login.fromJson(response);
  }
}
