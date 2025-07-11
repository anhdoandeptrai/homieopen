import 'package:app_homieopen_3047/common/models/api_response_model.dart';
import 'package:app_homieopen_3047/core/network/dio_client.dart';
import 'package:app_homieopen_3047/core/utils/constants/endpoint_constants.dart';
import 'package:app_homieopen_3047/core/utils/constants/message_constants.dart';
import 'package:app_homieopen_3047/core/utils/error/server_exception.dart';
import 'package:dio/dio.dart';

import '../models/comment/add_comment_params.dart';
import '../models/comment/comment_model.dart';
import '../models/comment/comment_params.dart';
import '../models/video/video_model.dart';

abstract interface class HomeRemoteDatasource {
  // Video
  Future<List<VideoModel>> getRecommendedVideos({required int page});
  Future<List<VideoModel>> getShortVideos({required int page});
  Future<List<VideoModel>> getLongVideos({required int page});
  // Comment
  Future<List<CommentModel>> getComments(CommentParams params);
  Future<CommentModel> addComment(AddCommentParams params);
  Future<void> deleteComment({required int id});
}

class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final DioClient _dioClient;

  HomeRemoteDatasourceImpl({required DioClient dioClient})
      : _dioClient = dioClient;

  @override
  Future<List<VideoModel>> getRecommendedVideos({required int page}) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.getRecommendedVideos,
        DioMethod.get,
        param: {
          'page': page,
          'limit': 10,
        },
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      final ApiResponseModel<List<VideoModel>> returnedData =
          ApiResponseModel<List<VideoModel>>.fromJson(
        res.data,
        (rawData) {
          if (rawData is Map<String, dynamic> &&
              rawData['videos'] is List<dynamic>) {
            final videosJson = rawData['videos'] as List<dynamic>;
            return videosJson.map((e) => VideoModel.fromJson(e)).toList();
          }
          return [];
        },
      );
      if (returnedData.data == null) {
        throw ServerException(message: MessageConstants.failure);
      }
      return returnedData.data ?? [];
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> getShortVideos({required int page}) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.getShortVideos,
        DioMethod.get,
        param: {
          'page': page,
          'limit': 10,
        },
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      final ApiResponseModel<List<VideoModel>> returnedData =
          ApiResponseModel<List<VideoModel>>.fromJson(
        res.data,
        (rawData) {
          if (rawData is Map<String, dynamic> &&
              rawData['videos'] is List<dynamic>) {
            final videosJson = rawData['videos'] as List<dynamic>;
            return videosJson.map((e) => VideoModel.fromJson(e)).toList();
          }
          return [];
        },
      );
      if (returnedData.data == null) {
        throw ServerException(message: MessageConstants.failure);
      }
      return returnedData.data ?? [];
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<VideoModel>> getLongVideos({required int page}) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.getShortVideos,
        DioMethod.get,
        param: {
          'page': page,
          'limit': 10,
        },
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      final ApiResponseModel<List<VideoModel>> returnedData =
          ApiResponseModel<List<VideoModel>>.fromJson(
        res.data,
        (rawData) {
          if (rawData is Map<String, dynamic> &&
              rawData['videos'] is List<dynamic>) {
            final videosJson = rawData['videos'] as List<dynamic>;
            return videosJson.map((e) => VideoModel.fromJson(e)).toList();
          }
          return [];
        },
      );
      if (returnedData.data == null) {
        throw ServerException(message: MessageConstants.failure);
      }
      return returnedData.data ?? [];
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<CommentModel> addComment(AddCommentParams params) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.comment,
        DioMethod.post,
        formData: FormData.fromMap(params.toJson()),
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      final ApiResponseModel<CommentModel> returnedData =
          ApiResponseModel<CommentModel>.fromJson(
        res.data,
        (rawData) => CommentModel.fromJson(rawData as Map<String, dynamic>),
      );
      if (returnedData.data == null) {
        throw ServerException(message: MessageConstants.failure);
      }
      return returnedData.data!;
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<void> deleteComment({required int id}) async {
    try {
      final res = await _dioClient.request(
        "${EndpointConstants.comment}/$id",
        DioMethod.delete,
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
    } on ServerException {
      rethrow;
    }
  }

  @override
  Future<List<CommentModel>> getComments(CommentParams params) async {
    try {
      final res = await _dioClient.request(
        EndpointConstants.comment,
        DioMethod.get,
        param: {
          'video_id': params.videoId,
          'page': params.page,
          'limit': params.limit,
        },
      );
      if (res.statusCode != 200) {
        throw ServerException(message: MessageConstants.failure);
      }
      final ApiResponseModel<List<CommentModel>> returnedData =
          ApiResponseModel<List<CommentModel>>.fromJson(
        res.data,
        (rawData) {
          if (rawData is Map<String, dynamic> &&
              rawData['comments'] is List<dynamic>) {
            final json = rawData['comments'] as List<dynamic>;
            return json.map((e) => CommentModel.fromJson(e)).toList();
          }
          return [];
        },
      );
      if (returnedData.data == null) {
        throw ServerException(message: MessageConstants.failure);
      }
      return returnedData.data ?? [];
    } on ServerException {
      rethrow;
    }
  }
}
