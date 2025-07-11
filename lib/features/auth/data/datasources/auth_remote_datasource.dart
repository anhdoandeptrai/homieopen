import 'package:app_homieopen_3047/core/network/dio_client.dart';
import 'package:app_homieopen_3047/core/utils/constants/endpoint_constants.dart';
import 'package:app_homieopen_3047/core/utils/constants/message_constants.dart';
import 'package:app_homieopen_3047/core/utils/error/server_exception.dart';
import 'package:dio/dio.dart';

import '../params/login_model.dart';
import '../params/login_params.dart';
import '../params/register_params.dart';

abstract interface class AuthRemoteDatasource {
  Future<String> login(LoginParams params);
  Future<String> register(RegisterParams params);
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient _dioClient;

  AuthRemoteDatasourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<String> login(LoginParams params) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.login,
        DioMethod.post,
        formData: FormData.fromMap(params.toJson()),
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      final LoginModel returnedData = LoginModel.fromJson(res.data);
      if (returnedData.accessToken == null) {
        throw ServerException(message: MessageConstants.failure);
      }
      return returnedData.accessToken!;
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<String> register(RegisterParams params) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.register,
        DioMethod.post,
        formData: FormData.fromMap(params.toJson()),
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      return MessageConstants.success;
    } on ServerException {
      rethrow;
    }
  }
}
