class AddCommentParams {
  final String content;
  final String videoId;

  AddCommentParams({
    required this.content,
    required this.videoId,
  });

  Map<String, dynamic> toJson() {
    return {
      "content": content,
      "video_id": videoId,
    };
  }
}
