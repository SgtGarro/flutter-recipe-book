import "package:flutter/material.dart";
import "package:recipe_book/models/recipe_model.dart";

class RecipeCardWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final RecipeModel recipe;
  final VoidCallback? onPressFavorite;
  final bool showFavoriteButton;

  const RecipeCardWidget({
    super.key,
    this.onTap,
    required this.recipe,
    this.onPressFavorite,
    this.showFavoriteButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .5,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              // decoration: BoxDecoration(color: Colors.deepPurple),
              child: Image.network(recipe.imageUrl, fit: BoxFit.cover),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipe.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 80,
                            color: Colors.deepPurple,
                            margin: EdgeInsets.symmetric(vertical: 2),
                          ),
                          Text(
                            'Difficulty: ${recipe.difficulty}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (showFavoriteButton) ...[
                      const SizedBox(width: 16),
                      IconButton(
                        icon: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            recipe.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            key: ValueKey<bool>(recipe.isFavorite),
                            color: Theme.of(context).primaryColor,
                          ),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(
                              scale: animation,
                              child: child,
                            );
                          },
                        ),
                        // icon: Icon(
                        //   recipe.isFavorite == true
                        //       ? Icons.favorite
                        //       : Icons.favorite_border,
                        // ),
                        onPressed: () {
                          onPressFavorite?.call();
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
