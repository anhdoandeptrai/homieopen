import 'video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required super.id,
    required super.name,
    required super.description,
    required super.link,
    required super.thumbnail,
    required super.viewCount,
    required super.type,
    required super.isRecommended,
    required super.videoReelIds,
    required super.hasLiked,
    super.lockStatus,
    required super.createdAt,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      link: json['link'],
      thumbnail: json['thumbnail'],
      viewCount: json['view_count'],
      type: json['type'],
      isRecommended: json['is_recommended'],
      videoReelIds: List<int>.from(json['video_reel_ids']),
      hasLiked: json['has_liked'],
      lockStatus: json['lock_status'],
      createdAt: json['created_at'],
    );
  }
}
