class RecipeModel {
  final int id;
  bool isFavorite = false;
  final String name;
  final String imageUrl;
  final String difficulty;
  final List<String> tags;
  List<String> ingredients;
  List<String> instructions;
  int preparationTimeInMinutes;
  int cookingTimeInMinutes;
  int servings;
  int caloriesPerServing;

  RecipeModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.difficulty,
    required this.tags,
    this.ingredients = const [],
    this.instructions = const [],
    required this.preparationTimeInMinutes,
    required this.cookingTimeInMinutes,
    required this.servings,
    required this.caloriesPerServing,
  });

  factory RecipeModel.fromJson(dynamic json) {
    final tags = List.castFrom<dynamic, String>(json['tags']);

    return RecipeModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image'],
      difficulty: json['difficulty'],
      tags: tags,
      ingredients: List.castFrom<dynamic, String>(json['ingredients']),
      instructions: List.castFrom<dynamic, String>(json['instructions']),
      preparationTimeInMinutes: json['prepTimeMinutes'],
      cookingTimeInMinutes: json['cookTimeMinutes'],
      servings: json['servings'],
      caloriesPerServing: json['caloriesPerServing'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
      'difficulty': difficulty,
      'isFavorite': isFavorite,
      'ingredients': ingredients,
      'instructions': instructions,
      'preparationTimeInMinutes': preparationTimeInMinutes,
      'cookTimeMinutes': cookingTimeInMinutes,
      'servings': servings,
      'caloriesPerServing': caloriesPerServing,
    };
  }

  @override
  String toString() {
    return 'RecipeModel{id:$id, name:$name, image:$imageUrl, difficulty:$difficulty}, isFavorite:$isFavorite';
  }
}
