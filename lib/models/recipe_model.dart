class RecipeModel {
  final int id;
  bool isFavorite = false;
  final String name;
  final String imageUrl;
  final String difficulty;
  final List<String> tags;

  RecipeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.difficulty,
    required this.tags,
  });

  factory RecipeModel.fromJson(dynamic json) {
    final tags = List.castFrom<dynamic, String>(json['tags']);

    return RecipeModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
      difficulty: json['difficulty'],
      tags: tags,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
      'difficulty': difficulty,
      'isFavorite': isFavorite,
    };
  }

  @override
  String toString() {
    return 'RecipeModel{id:$id, name:$name, image:$imageUrl, difficulty:$difficulty}, isFavorite:$isFavorite';
  }
}
