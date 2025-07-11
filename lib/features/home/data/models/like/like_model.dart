class LikeEntity {
  final bool liked;
  final String message;

  LikeEntity({
    required this.liked,
    required this.message,
  });

  LikeEntity copyWith({
    bool? liked,
    String? message,
  }) {
    return LikeEntity(
      liked: liked ?? this.liked,
      message: message ?? this.message,
    );
  }
}

class LikeModel extends LikeEntity {
  LikeModel({
    required super.liked,
    required super.message,
  });

  factory LikeModel.fromJson(Map<String, dynamic> json) {
    return LikeModel(
      liked: json['liked'],
      message: json['message'],
    );
  }
}
