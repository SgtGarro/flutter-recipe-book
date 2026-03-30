import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/widgets/recipe_list_widget.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              "Your favorite recipes",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Consumer<RecipesProvider>(
                builder: (context, provider, child) {
                  return RecipeListWidget(
                    recipeList: provider.favoriteRecipesList,
                    isLoading: provider.isLoading,
                    showError: provider.hasError,
                    showFavoriteButton: false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
