import 'package:dio/dio.dart';
import 'dart:io';

import 'package:fb_login_google/contains/base_url.dart';

class BaseProvider {
  Dio dio = new Dio();
  final String baseUrl = BaseUrl.url;

  getHeader() {
    return {HttpHeaders.contentTypeHeader: 'application/json'};
  }

  Future<dynamic> get(String uri) async {
    try {
      final response =
          await dio.get("${_getUrl(uri)}", options: Options(headers: null));
      return response.data;
    } catch (e) {}
  }

  _getUrl(String uri) {
    var url = uri;
    if (!uri.startsWith('http')) {
      url = "$baseUrl/$uri";
    }
    return url;
  }
}
