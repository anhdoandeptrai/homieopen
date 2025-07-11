import 'package:app_homieopen_3047/core/utils/error/failure.dart';
import 'package:app_homieopen_3047/core/utils/usecase.dart';
import 'package:dartz/dartz.dart';

import '../../data/models/video/video_entity.dart';
import '../repositories/home_repository.dart';

class GetLongVideosUsecase implements Usecase<List<VideoEntity>, int> {
  final HomeRepository _homeRepository;

  GetLongVideosUsecase({required HomeRepository homeRepository})
      : _homeRepository = homeRepository;

  @override
  Future<Either<Failure, List<VideoEntity>>> call(int page) async {
    return await _homeRepository.getLongVideos(page: page);
  }
}
