import 'package:flutter/material.dart';

import '../models/recipe_model.dart';

class RecipeDetail extends StatelessWidget {
  final RecipeModel recipe;
  const RecipeDetail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(recipe.name),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Column(children: [
          Text(recipe.name, style: Theme.of(context).textTheme.titleLarge)
        ],),
      ),
    );
  }
}
