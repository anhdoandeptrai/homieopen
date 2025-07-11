class AddVideoToCollectionParams {
  final int videoCollectionId;
  final int videoId;

  AddVideoToCollectionParams({
    required this.videoCollectionId,
    required this.videoId,
  });

  Map<String, dynamic> toJson() {
    return {
      "video_collection_id": videoCollectionId,
      "video_id": videoId,
    };
  }
}
