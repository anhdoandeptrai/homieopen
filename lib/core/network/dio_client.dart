import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../local/shared_prefs_service.dart';
import '../utils/constants/message_constants.dart';
import '../utils/error/server_exception.dart';
import 'app_interceptor.dart';

enum DioMethod { get, post, put, delete }

class DioClient {
  final Dio _dio;

  DioClient({required SharedPrefsService sharedPrefsService})
      : _dio = Dio(
          BaseOptions(
            baseUrl: dotenv.get('BASE_URL'),
            headers: {
              'X-TOKEN-ACCESS': dotenv.get('API_KEY'),
            },
            responseType: ResponseType.json,
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        )..interceptors.addAll([
            AppInterceptor(sharedPrefsService: sharedPrefsService),
            LogInterceptor(
              request: true,
              requestBody: true,
              requestHeader: true,
            ),
          ]);

  Future<Response> request(
    String endpoint,
    DioMethod method, {
    Map<String, dynamic>? param,
    formData,
  }) async {
    try {
      switch (method) {
        case DioMethod.get:
          return await _dio.get(
            endpoint,
            queryParameters: param,
          );
        case DioMethod.post:
          return await _dio.post(
            endpoint,
            queryParameters: param,
            data: formData,
          );
        case DioMethod.put:
          return await _dio.put(
            endpoint,
            queryParameters: param,
            data: formData,
          );
        case DioMethod.delete:
          return await _dio.delete(
            endpoint,
            queryParameters: param,
            data: formData,
          );
      }
    } on DioException catch (e) {
      final rawData = e.response?.data;
      String errorMessage = MessageConstants.failure;

      try {
        errorMessage =
            _catchErrors(rawData is Map<String, dynamic> ? rawData : {});
      } catch (err) {
        debugPrint("⚠️ ERROR IN _catchErrors: $err");
      }

      throw ServerException(message: errorMessage);
    } catch (e) {
      throw ServerException(message: MessageConstants.failure);
    }
  }

  String _catchErrors(Map<String, dynamic> errors) {
    if (errors.containsKey('message_validate')) {
      final messages = errors['message_validate'] as Map<String, dynamic>;
      if (messages.containsKey('identifier')) {
        return messages['identifier'].first;
      } else if (messages.containsKey('id')) {
        return messages['id'].first;
      } else if (messages.containsKey('phone')) {
        return messages['phone'].first;
      } else if (messages.containsKey('password')) {
        return messages['password'].first;
      }
    }
    if (errors.containsKey('message')) {
      return errors['message'] is String
          ? errors['message']
          : MessageConstants.failure;
    }
    return MessageConstants.failure;
  }
}
