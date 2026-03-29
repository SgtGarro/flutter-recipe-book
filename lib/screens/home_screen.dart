import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/models/recipe_model.dart';
import 'package:recipe_book/providers/recipes_provider.dart';
import 'package:recipe_book/screens/recipe_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipesProvider = Provider.of<RecipesProvider>(
      context,
      listen: false,
    );
    recipesProvider.fetchRecipes();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Consumer<RecipesProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (provider.hasError) {
              return const Center(
                child: Text("Ups! There's an error retrieving the recipes"),
              );
            }

            if (provider.recipeList.isEmpty) {
              return const Center(child: Text("No recipes found"));
            }

            return ListView.builder(
              itemCount: provider.recipeList.length,
              itemBuilder: (context, index) =>
                  _buildRecipesCard(context, provider.recipeList[index]),
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

  Widget _buildRecipesCard(BuildContext context, RecipeModel recipe) {
    return GestureDetector(
      child: Card(
        elevation: .5,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetail(recipe: recipe),
            ),
          ),
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
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
            ],
          ),
        ),
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
