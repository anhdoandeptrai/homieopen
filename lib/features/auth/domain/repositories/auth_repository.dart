import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/params/login_params.dart';
import '../../data/params/register_params.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> login(LoginParams params);

  Future<Either<Failure, String>> register(RegisterParams params);
}
