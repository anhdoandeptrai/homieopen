import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/comment/add_comment_params.dart';
import '../../data/models/comment/comment_entity.dart';
import '../repositories/home_repository.dart';

class AddCommentUsecase implements Usecase<CommentEntity, AddCommentParams> {
  final HomeRepository _homeRepository;

  AddCommentUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, CommentEntity>> call(AddCommentParams params) async {
    return await _homeRepository.addComment(params);
  }
}
