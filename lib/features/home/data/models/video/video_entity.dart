class VideoEntity {
  final int id;
  final String name;
  final String description;
  final String link;
  final String thumbnail;
  final int viewCount;
  final String type;
  final String isRecommended;
  final List<int> videoReelIds;
  final bool hasLiked;
  final String? lockStatus;
  final String createdAt;

  VideoEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.link,
    required this.thumbnail,
    required this.viewCount,
    required this.type,
    required this.isRecommended,
    required this.videoReelIds,
    required this.hasLiked,
    this.lockStatus,
    required this.createdAt,
  });

  VideoEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? link,
    String? thumbnail,
    int? viewCount,
    String? type,
    String? isRecommended,
    List<int>? videoReelIds,
    bool? hasLiked,
    String? lockStatus,
    String? createdAt,
  }) {
    return VideoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      link: link ?? this.link,
      thumbnail: thumbnail ?? this.thumbnail,
      viewCount: viewCount ?? this.viewCount,
      type: type ?? this.type,
      isRecommended: isRecommended ?? this.isRecommended,
      videoReelIds: videoReelIds ?? this.videoReelIds,
      hasLiked: hasLiked ?? this.hasLiked,
      lockStatus: lockStatus ?? this.lockStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
