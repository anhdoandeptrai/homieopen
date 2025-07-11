import '../video/video_model.dart';
import 'long_video_entity.dart';

class LongVideoModel extends LongVideoEntity {
  LongVideoModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.status,
    required super.disableComments,
    required super.subtitles,
    required super.viewTotal,
    required super.videos,
  });

  factory LongVideoModel.fromJson(Map<String, dynamic> json) {
    return LongVideoModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      status: json['status'],
      disableComments: json['disable_comments'],
      subtitles: json['subtitles'],
      viewTotal: json['view_total'],
      videos:
          (json['videos'] as List).map((e) => VideoModel.fromJson(e)).toList(),
    );
  }
}
