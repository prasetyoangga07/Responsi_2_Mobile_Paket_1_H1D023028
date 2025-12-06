class ApiUrl {
  static const String baseUrl = "http://192.168.1.18:8080";

  static const String login = "$baseUrl/login";
  static const String registrasi = "$baseUrl/registrasi";

  static const String listInventaris = "$baseUrl/inventaris";
  static const String createInventaris = "$baseUrl/inventaris";

  static String updateInventaris(int id) => "$baseUrl/inventaris/$id";
  static String deleteInventaris(int id) => "$baseUrl/inventaris/$id";
}
