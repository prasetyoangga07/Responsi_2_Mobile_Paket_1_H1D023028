import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'app_exception.dart';

class Api {
  Future<dynamic> post(String url, dynamic data) async {
    try {
      final response = await http.post(Uri.parse(url), body: data);
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("Tidak ada koneksi internet");
    }
  }

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("Tidak ada koneksi internet");
    }
  }

  Future<dynamic> put(String url, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {HttpHeaders.contentTypeHeader: "application/json"},
        body: data,
      );
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("Tidak ada koneksi internet");
    }
  }

  Future<dynamic> delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(url));
      return _returnResponse(response);
    } on SocketException {
      throw FetchDataException("Tidak ada koneksi internet");
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 404:
        throw BadRequestException("Tidak ditemukan");
      default:
        throw FetchDataException(
          'Error komunikasi dengan server (Code: ${response.statusCode})',
        );
    }
  }
}
