import 'package:dartz/dartz.dart';

import 'error/failure.dart';

abstract interface class Usecase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class NoParam {}