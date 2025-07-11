import 'collection_entity.dart';

class CollectionModel extends CollectionEntity {
  CollectionModel({
    required super.id,
    required super.name,
    required super.description,
    required super.avatar,
  });

  factory CollectionModel.fromJson(Map<String, dynamic> json) {
    return CollectionModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      avatar: json['avatar'],
    );
  }
}
