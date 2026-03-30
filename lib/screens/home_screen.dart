import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:recipe_book/widgets/recipe_list_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Consumer<RecipesProvider>(
          builder: (context, provider, child) {
            return RecipeListWidget(
              recipeList: provider.recipeList,
              isLoading: provider.isLoading,
              showError: provider.hasError,
              onPressFavorite: (recipe) => provider.toggleFavorite(recipe),
              onTap: (recipe) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetail(recipe: recipe),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showBottom(context),
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Wrap(children: [RecipeForm()]),
      ),
    );
  }
}

class RecipeForm extends StatelessWidget {
  RecipeForm({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _recipeName = TextEditingController();
  final TextEditingController _authorName = TextEditingController();
  final TextEditingController _recipeImageUrl = TextEditingController();
  final TextEditingController _recipeDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _validateEmptyFields(String? value) {
      if (value == null || value == '') {
        return 'Field required';
      }
      return '';
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add new recipe",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 16),
            Flex(
              direction: Axis.vertical,
              spacing: 16,
              children: [
                _buildTextField(
                  controller: _recipeName,
                  label: "Recipe name",
                  validator: _validateEmptyFields,
                ),
                _buildTextField(
                  controller: _authorName,
                  label: "Author name",
                  validator: _validateEmptyFields,
                ),
                _buildTextField(
                  controller: _recipeDescription,
                  label: "Description",
                  validator: _validateEmptyFields,
                ),
                _buildTextField(
                  controller: _recipeImageUrl,
                  label: "Image URL",
                  validator: _validateEmptyFields,
                ),
              ],
            ),
            SizedBox(height: 16),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              // style: ButtonStyle(
              //   shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              //     RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(5),
              //     ),
              //   ),
              // ),
              onPressed: () {
                if (_formKey.currentState!.validate()) Navigator.pop(context);
              },
              child: Text("Save recipe"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String Function(String?) validator,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontFamily: 'Quicksand'),
        focusColor: Colors.deepPurple,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      ),
    );
  }
}
