import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../data/params/login_params.dart';
import '../repositories/auth_repository.dart';

class LoginUsecase implements Usecase<String, LoginParams> {
  final AuthRepository _authRepository;

  LoginUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> call(LoginParams param) async {
    return await _authRepository.login(param);
  }
}