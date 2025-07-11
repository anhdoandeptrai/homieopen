class CollectionEntity {
  final int id;
  final String name;
  final String description;
  final String avatar;

  CollectionEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.avatar,
  });

  CollectionEntity copyWith({
    int? id,
    String? name,
    String? description,
    String? avatar,
  }) {
    return CollectionEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      avatar: avatar ?? this.avatar,
    );
  }
}
