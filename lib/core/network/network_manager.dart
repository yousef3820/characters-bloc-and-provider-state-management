import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter_application_bloc_state_management/core/errors/error_model.dart';
import 'package:flutter_application_bloc_state_management/core/network/api_protocol.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkManager {
  final _dio = Dio();
  NetworkManager() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback = (cert, host, port) =>
          true; // allow all SSL certificates (DEV only)
      return client;
    };
    _dio.interceptors.add(
      PrettyDioLogger(
        error: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
      ),
    );
  }
  Future<T> perform<T>(ApiRequest<T> requset) async {
    final baseUrl = "${requset.baseUrl}${requset.path}";
    try {
      final result = await _dio.request(
        baseUrl,
        data: requset.body,
        queryParameters: requset.queryParameters,
        options: Options(
          headers: requset.headers,
          responseType: ResponseType.json,
          method: requset.method,
        ),
      );
      return requset.performParse(result);
    } on DioException catch (e) {
      handleExceptions(e);
      rethrow;
    }
  }
}
