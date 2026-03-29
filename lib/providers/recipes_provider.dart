import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  List<RecipeModel> recipeList = [];

  Future<void> fetchRecipes() async {
    try {
      isLoading = true;
      hasError = false;
      notifyListeners();
      final url = Uri.parse('https://dummyjson.com/recipes');
      final response = await http.get(url);
      final data = jsonDecode(response.body);
      final rawRecipes = data['recipes'] as List<dynamic>;
      final recipes = rawRecipes
          .map((dto) => RecipeModel.fromJson(dto))
          .toList();

      recipeList = recipes;
    } catch (e, st) {
      debugPrint('Error fetching recipes: $e\n$st');
      recipeList = [];
      hasError = true;
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}