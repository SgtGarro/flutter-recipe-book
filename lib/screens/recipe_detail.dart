import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/providers/recipes_provider.dart';

import '../models/recipe_model.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          recipe.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                recipe.imageUrl,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    buildSectionCard(
                      context: context,
                      title: "Recipe information",
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Difficulty: ",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: recipe.difficulty,
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Preparation Time: ",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text:
                                      "${recipe.preparationTimeInMinutes} minutes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Cooking Time: ",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text:
                                      "${recipe.cookingTimeInMinutes} minutes",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Servings: ",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "${recipe.servings}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: "Calories per Serving: ",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: "${recipe.caloriesPerServing}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    buildSectionCard(
                      context: context,
                      title: "Ingredients",
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          ...recipe.ingredients.map(
                            (ingredient) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• '),
                                Expanded(child: Text(ingredient)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    buildSectionCard(
                      context: context,
                      title: "Instructions",
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          ...recipe.instructions.asMap().entries.map(
                            (entry) => Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${entry.key + 1}. '),
                                Expanded(child: Text(entry.value)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Consumer<RecipesProvider>(
        builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: () {
              provider.toggleFavorite(recipe);
            },
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            child: Icon(
              recipe.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
          );
        },
      ),
    );
  }

  Widget buildSectionCard({
    required BuildContext context,
    required String title,
    required Widget body,
  }) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        elevation: 2,
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium!.copyWith(color: Colors.deepPurple),
              ),
              SizedBox(height: 12),
              body,
            ],
          ),
        ),
      ),
    );
  }
}
