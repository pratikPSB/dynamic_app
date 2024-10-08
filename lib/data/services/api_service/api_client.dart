import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../constants/const_keys.dart';

class DioService {
  late Dio _dio;
  late final String _baseUrl;

  DioService({required String baseUrl}) {
    _baseUrl = baseUrl;
    BaseOptions options = BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 10),
      contentType: ConstKeys.contentTypeValue,
      responseType: ResponseType.json,
    );

    _dio = Dio(options);

    if (kDebugMode) {
      final prettyDioLogger = PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
          error: true,
          maxWidth: 150);
      _dio.interceptors.add(prettyDioLogger);
    }
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> queries = const <String, dynamic>{},
  }) async {
    Options requestOptions =
        Options(headers: headers, responseType: ResponseType.json);
    var response = await _dio.get(
      endpoint,
      queryParameters: queries,
      options: requestOptions,
    );
    return checkResponseType(response.data);
  }

  Future<dynamic> post({
    required String endpoint,
    Map<String, dynamic> headers = const <String, dynamic>{},
    Map<String, dynamic> data = const <String, dynamic>{},
    bool isFormURLEncoded = false,
  }) async {
    Options requestOptions =
        Options(headers: headers, responseType: ResponseType.json);
    if (isFormURLEncoded) {
      requestOptions.contentType = 'application/x-www-form-urlencoded';
    }
    var response = await _dio.post(
      endpoint,
      data: data,
      options: requestOptions,
    );
    return response.data;
    // return checkResponseType(response.data);
  }

  String checkResponseType(data) {
    return jsonEncode(data);
  }
}
