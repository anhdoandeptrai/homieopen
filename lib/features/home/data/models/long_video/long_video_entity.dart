import '../video/video_model.dart';

class LongVideoEntity {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final String status;
  final String disableComments;
  final String subtitles;
  final int viewTotal;
  final List<VideoModel> videos;

  LongVideoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.status,
    required this.disableComments,
    required this.subtitles,
    required this.viewTotal,
    required this.videos,
  });

  LongVideoEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? imageUrl,
    String? status,
    String? disableComments,
    String? subtitles,
    int? viewTotal,
    List<VideoModel>? videos,
  }) {
    return LongVideoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      disableComments: disableComments ?? this.disableComments,
      subtitles: subtitles ?? this.subtitles,
      viewTotal: viewTotal ?? this.viewTotal,
      videos: videos ?? this.videos,
    );
  }
}
