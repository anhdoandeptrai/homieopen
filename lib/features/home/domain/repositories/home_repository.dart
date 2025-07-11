import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/comment/add_comment_params.dart';
import '../../data/models/comment/comment_entity.dart';
import '../../data/models/comment/comment_params.dart';
import '../../data/models/video/video_entity.dart';

abstract interface class HomeRepository {
  //Video
  Future<Either<Failure, List<VideoEntity>>> getRecommendedVideos(
      {required int page});
  Future<Either<Failure, List<VideoEntity>>> getShortVideos(
      {required int page});
  Future<Either<Failure, List<VideoEntity>>> getLongVideos({required int page});
  // Comment
  Future<Either<Failure, List<CommentEntity>>> getComments(
      CommentParams params);
  Future<Either<Failure, CommentEntity>> addComment(AddCommentParams params);
  Future<Either<Failure, void>> deleteComment({required int id});
}
