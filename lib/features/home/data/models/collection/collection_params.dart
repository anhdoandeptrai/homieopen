class CollectionParams {
  final String name;
  final String description;
  final String avatar;

  CollectionParams({
    required this.name,
    required this.description,
    required this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "avatar": avatar,
    };
  }
}