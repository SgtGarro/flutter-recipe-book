class RecipeModel {
  final String name;
  final String imageUrl;
  final String difficulty;
  final List<String> tags;

  RecipeModel({
    required this.name,
    required this.imageUrl,
    required this.difficulty,
    required this.tags,
  });

  factory RecipeModel.fromJson(dynamic json) {
    final tags = List.castFrom<dynamic, String>(json['tags']);

    return RecipeModel(
      name: json['name'],
      imageUrl: json['image'],
      difficulty: json['difficulty'],
      tags: tags,
    );
  }

  Map<String, dynamic> toJSON() {
    return {'name': name, 'image': imageUrl, 'difficulty': difficulty};
  }

  @override
  String toString() {
    return 'RecipeModel{name:$name, image:$imageUrl, difficulty:$difficulty}';
  }
}
