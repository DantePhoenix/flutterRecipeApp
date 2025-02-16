import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recetas_app/screens/recipe_detail.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

//Crear la conexion a la Api de moockon
  Future<List<dynamic>> _fetchRecipes() async {
    //Url que apunta a la api cre cree en moockon
    final url = Uri.parse('http://10.0.2.2:54093/recipes');
    // VALIDACIONES DE ERRORES
    try {
      final response = await http.get(url); //Se hace la petición get a la url
      // si la respuesta es un 200
      if (response.statusCode == 200) {
        // decodificar la respuesta a un formato Json y solo entregar el body
        final data = json.decode(response.body);
        // apuntar al objeto que contiene todo lo demás (primero pasar por recipes para luego obtener los demás objetos
        return data['recipes'];
      } else {
        // ignore: avoid_print
        print('Error:  ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error in request');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _fetchRecipes(), // Trae la respuesta de la api
          builder: (context, snapshot) {
            final recipes = snapshot.data ?? []; // sino hay datos pone vacio
            // VALIDACIONES DE ERRORES
            // Si tarda en cargar las imagenes
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white70,
                backgroundColor: Colors.orange,
              ));
            } else if
                //Si los datos llegan vacíos
                (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No recipes found'));
            } else {
              // Si todo esta correcto
              return ListView.builder(
                  itemCount: recipes
                      .length, // cuenta la cantidad de datos de respuesta
                  itemBuilder: (BuildContext context, int index) {
                    return _recipesCard(context, recipes[index]);
                  });
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottom(context);
        },
        backgroundColor: Colors.orange[400],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> _showBottom(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 600,
        width: MediaQuery.of(context)
            .size
            .width, // toma todo el ancho disponible de la pantalla
        color: Colors.white,
        child: const RecipeForm(),
      ),
    );
  }
}

Widget _recipesCard(BuildContext context, dynamic recipe) {
  // gesture detector detecta las interacciones en la pantalla
  return GestureDetector(
    onTap: () {
      // Navegación a otra pantalla definida con materialPageRouter
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecipeDetail(recipeName: recipe['name'])));
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 125,
        child: Card(
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 125,
                width: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    recipe['image_link'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 26,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipe['name'],
                    style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    height: 2,
                    width: 75,
                    color: Colors.orange,
                  ),
                  Text(recipe['author'],
                      style: TextStyle(fontSize: 16, fontFamily: 'Quicksand')),
                  SizedBox(
                    height: 4,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

//Formulario para crear la receta
class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey =
        GlobalKey<FormState>(); // almacena el estado del formulario en una key

    // Es necesario declarar un controlador para cada uno de los campo del formulario
    //capturando lo ingresado en cada input y guardandolo en el estado
    final TextEditingController recipeNameController = TextEditingController();
    final TextEditingController authorNameController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();
    final TextEditingController recipeController = TextEditingController();
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('  Add New Recipe',
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.orange[400],
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            // cada input debe tener asignado su propio controller y validador
            _buildTextField(
                label: 'Recipe Name',
                controller: recipeNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            _buildTextField(
                label: 'Author Name',
                controller: authorNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a author name';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            _buildTextField(
                label: 'Image Url',
                controller: imageUrlController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a image url';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            _buildTextField(
                label: 'Recipe',
                controller: recipeController,
                maxLines: 4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                }),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Add Recipe',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Construcción personalizada de los campos de texto (input)
  // maxLines se usas para incrementar la cantidad de lineas que puede recibir un input
  Widget _buildTextField(
      //parametros requeridos por la funcion
      {required String label,
      required TextEditingController controller,
      required String? Function(dynamic value) validator,
      int? maxLines = 1}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.orange,
          fontFamily: 'Quicksand',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.orange, width: 1),
        ),
      ),
      // se deben asignar los controladores y validadores a cada input
      validator: validator,
      maxLines: maxLines,
    );
  }
}
