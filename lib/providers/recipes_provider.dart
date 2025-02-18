import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recetas_app/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];
  List<Recipe> favoriteRecipes = [];
  // implementando variable de entorno global para la url de la api
  final apiUrl = dotenv.env['API_URL'];

  //Crear la conexion a la Api de moockon
  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();

    //Url que apunta a la api cre cree en moockon
    // llamandola desde variable de entorno
    final url = Uri.parse('$apiUrl/recipes');
    // VALIDACIONES DE ERRORES
    try {
      final response = await http.get(url); //Se hace la petición get a la url
      // si la respuesta es un 200
      if (response.statusCode == 200) {
        // decodificar la respuesta a un formato Json y solo entregar el body
        final data = json.decode(response.body);
        recipes = List<Recipe>.from(
            data['recipes'].map((recipe) => Recipe.fromJson(recipe)));
      } else {
        // ignore: avoid_print
        print('Error:  ${response.statusCode}');
        recipes = [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error in request');
      recipes = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Recipe recipe) async {
    final isFavorite = favoriteRecipes.contains(recipe);

    try {
      final url = Uri.parse('$apiUrl/favorites');
      final response = isFavorite
          ? await http.delete(url, body: json.encode({'id': recipe.id}))
          : await http.post(url, body: json.encode(recipe.toJson()));

      if (response.statusCode == 200) {
        if (isFavorite) {
          favoriteRecipes.remove(recipe);
        } else {
          favoriteRecipes.add(recipe);
        }
        notifyListeners();
      } else {
        throw Exception('Failed to update favorite recipe');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error updating favorite recipe: $e');
    }
  }
}
