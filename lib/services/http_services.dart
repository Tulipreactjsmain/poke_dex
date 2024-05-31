// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class HTTPService {
  final _dio = Dio();

  Future<Response?> get(String url) async {
    try {
      Response response = await _dio.get(url);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}


