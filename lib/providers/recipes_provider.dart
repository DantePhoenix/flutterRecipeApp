import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recetas_app/models/recipe_model.dart';

class RecipesProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Recipe> recipes = [];

  //Crear la conexion a la Api de moockon
  Future<void> fetchRecipes() async {
    isLoading = true;
    notifyListeners();

    //Url que apunta a la api cre cree en moockon
    final url = Uri.parse('http://10.0.2.2:54093/recipes');
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
}
