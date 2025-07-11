import 'comment_user_model.dart';

class CommentEntity {
  final int id;
  final String content;
  final String createdAt;
   final CommentUserEntity user;

  CommentEntity({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
  });

  CommentEntity copyWith({
    int? id,
    String? content,
    String? createdAt,
    CommentUserEntity? user,
  }) {
    return CommentEntity(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }
}