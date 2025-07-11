import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/home_repository.dart';

class DeleteCommentUsecase implements Usecase<void, int> {
  final HomeRepository _homeRepository;

  DeleteCommentUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await _homeRepository.deleteComment(id: id);
  }
}
