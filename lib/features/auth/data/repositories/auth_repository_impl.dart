import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/error/server_exception.dart';
import 'package:dartz/dartz.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../params/login_params.dart';
import '../params/register_params.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDatasource authRemoteDataSource})
      : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, String>> login(LoginParams params) async {
    try {
      final token = await _authRemoteDataSource.login(params);
      return Right(token);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> register(RegisterParams params) async {
    try {
      final message = await _authRemoteDataSource.register(params);
      return Right(message);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
