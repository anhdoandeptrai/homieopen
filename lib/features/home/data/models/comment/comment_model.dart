import 'comment_entity.dart';
import 'comment_user_model.dart';

class CommentModel extends CommentEntity {
  CommentModel({
    required super.id,
    required super.content,
    required super.createdAt,
    required super.user,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      content: json['content'],
      createdAt: json['created_at'],
      user: CommentUserModel.fromJson(json['user']),
    );
  }
}
