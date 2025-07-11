class CommentUserEntity {
  final String fullname;
  final String avatar;
  final String? createdAt;

  CommentUserEntity({
    required this.fullname,
    required this.avatar,
    this.createdAt,
  });

  CommentUserEntity copyWith({
    String? fullname,
    String? avatar,
    String? createdAt,
  }) {
    return CommentUserEntity(
      fullname: fullname ?? this.fullname,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class CommentUserModel extends CommentUserEntity {
  CommentUserModel({
    required super.fullname,
    required super.avatar,
    required super.createdAt,
  });

  factory CommentUserModel.fromJson(Map<String, dynamic> json) {
    return CommentUserModel(
      fullname: json['fullname'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
    );
  }
}
