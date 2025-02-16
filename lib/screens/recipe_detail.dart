import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas_app/models/recipe_model.dart';
import 'package:recetas_app/providers/recipes_provider.dart';

class RecipeDetail extends StatefulWidget {
  //Se deben colocar las cosas que la pantalla de recetas va a recibir
  // es obligatorio pasarlo también en el constructor
  final Recipe recipesData;
  const RecipeDetail(
      {super.key, required this.recipesData}); // Soy un constructor :)

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  bool isFavorite = false; // Inicializamos la variable favorito en false

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    isFavorite = Provider.of<RecipesProvider>(context, listen: false)
        .favoriteRecipes
        .contains(widget.recipesData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 130, // Aumentamos la altura para dar más espacio
        title: Text(widget.recipesData.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<RecipesProvider>(context, listen: false)
                  .toggleFavoriteStatus(widget.recipesData);
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Image.network(widget.recipesData.image_link),
            SizedBox(
              height: 8,
            ),
            Text(
              widget.recipesData.name,
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            ),
            SizedBox(
              height: 8,
            ),
            Text("by: ${widget.recipesData.author}"),
            Container(
              height: 2,
              width: 200,
              color: Colors.orange,
            ),
            SizedBox(
              height: 20,
            ),
            const Text(
              'Recipe steps:',
              style: TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Quicksand'),
            ),
            for (var step in widget.recipesData.recipeSteps)
              Text(
                "- $step",
                textAlign: TextAlign.start,
              ),
          ],
        ),
      ),
    );
  }
}
