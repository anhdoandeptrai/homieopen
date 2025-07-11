import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/error/server_exception.dart';
import 'package:app_homieopen_3047/features/home/data/models/comment/add_comment_params.dart';
import 'package:app_homieopen_3047/features/home/data/models/comment/comment_entity.dart';
import 'package:app_homieopen_3047/features/home/data/models/comment/comment_params.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/video/video_entity.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _homeRemoteDatasource;

  HomeRepositoryImpl({required HomeRemoteDatasource homeRemoteDatasource})
      : _homeRemoteDatasource = homeRemoteDatasource;

  @override
  Future<Either<Failure, List<VideoEntity>>> getRecommendedVideos(
      {required int page}) async {
    try {
      final returnedData =
          await _homeRemoteDatasource.getRecommendedVideos(page: page);
      return Right(returnedData);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getShortVideos(
      {required int page}) async {
    try {
      final returnedData =
          await _homeRemoteDatasource.getShortVideos(page: page);
      return Right(returnedData);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getLongVideos(
      {required int page}) async {
    try {
      final returnedData =
          await _homeRemoteDatasource.getLongVideos(page: page);
      return Right(returnedData);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, CommentEntity>> addComment(
      AddCommentParams params) async {
    try {
      final returnedData = await _homeRemoteDatasource.addComment(params);
      return Right(returnedData);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteComment({required int id}) async {
    try {
      final returnedData = await _homeRemoteDatasource.deleteComment(id: id);
      return Right(returnedData);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
      CommentParams params) async {
    try {
      final returnedData = await _homeRemoteDatasource.getComments(params);
      return Right(returnedData);
    } on ServerException catch (e) {
      return Left(Failure(message: e.message));
    }
  }
}
