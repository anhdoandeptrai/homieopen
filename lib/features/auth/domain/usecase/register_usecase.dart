import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../data/params/register_params.dart';
import '../repositories/auth_repository.dart';

class RegisterUsecase implements Usecase<String, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, String>> call(RegisterParams param) async {
    return await _authRepository.register(param);
  }
}