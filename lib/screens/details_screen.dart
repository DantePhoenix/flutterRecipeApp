import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas_app/models/recipe_model.dart';
import 'package:recetas_app/providers/recipes_provider.dart';
import 'package:recetas_app/screens/recipe_detail.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RecipesProvider>(
        builder: (context, recipesProvider, child) {
          final favoritesRecipes = recipesProvider.favoriteRecipes;

          return favoritesRecipes.isEmpty
              ? Center(child: Text('No favorites recipes'))
              : ListView.builder(
                  itemCount: favoritesRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = favoritesRecipes[index];
                    return FavoriteRecipesCard(recipe: recipe);
                  });
        },
      ),
    );
  }
}

class FavoriteRecipesCard extends StatelessWidget {
  final Recipe recipe;
  const FavoriteRecipesCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RecipeDetail(recipesData: recipe)));
      },
      child: Card(
        color: Colors.white,
        child: Column(
          children: [
            Text(recipe.name),
            Text(recipe.author),
          ],
        ),
      ),
    );
  }
}
