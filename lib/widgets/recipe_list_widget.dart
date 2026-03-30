import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:recipe_book/models/recipe_model.dart";
import "package:recipe_book/providers/recipes_provider.dart";
import "package:recipe_book/screens/recipe_detail.dart";
import "package:recipe_book/widgets/recipe_card_widget.dart";

class RecipeListWidget extends StatelessWidget {
  final List<RecipeModel> recipeList;
  final bool isLoading;
  final bool showError;
  final Function(RecipeModel)? onPressFavorite;
  final Function(RecipeModel)? onTap;
  final bool showFavoriteButton;

  const RecipeListWidget({
    super.key,
    required this.recipeList,
    required this.isLoading,
    required this.showError,
    this.onPressFavorite,
    this.onTap,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (showError) {
      return const Center(
        child: Text("Ups! There's an error retrieving the recipes"),
      );
    }

    if (recipeList.isEmpty) {
      return const Center(child: Text("No recipes found"));
    }

    return Consumer<RecipesProvider>(
      builder: (c, provider, child) {
        return ListView.builder(
          itemCount: recipeList.length,
          itemBuilder: (_, index) => RecipeCardWidget(
            recipe: recipeList[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetail(recipe: recipeList[index]),
                ),
              );
            },
            onPressFavorite: () => onPressFavorite?.call(recipeList[index]),
            showFavoriteButton: showFavoriteButton,
          ),
        );
      },
    );
  }
}
