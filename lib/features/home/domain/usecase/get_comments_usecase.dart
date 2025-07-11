import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/comment/comment_entity.dart';
import '../../data/models/comment/comment_params.dart';
import '../repositories/home_repository.dart';

class GetCommentsUsecase
    implements Usecase<List<CommentEntity>, CommentParams> {
  final HomeRepository _homeRepository;

  GetCommentsUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, List<CommentEntity>>> call(
      CommentParams params) async {
    return await _homeRepository.getComments(params);
  }
}
