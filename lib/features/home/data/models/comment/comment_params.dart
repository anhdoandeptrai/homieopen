class CommentParams {
  final int page;
  final int limit;
  final String videoId;

  CommentParams({
    required this.page,
    this.limit = 10,
    required this.videoId,
  });

  Map<String, dynamic> toJson() {
    return {
      "page": page,
      "limit": limit,
      "video_id": videoId,
    };
  }
}
