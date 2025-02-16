import 'package:flutter/material.dart';

class RecipeDetail extends StatefulWidget {
  //Se deben colocar las cosas que la pantalla de recetas va a recibir
  // es obligatorio pasarlo también en el constructor
  final String recipeName;
  const RecipeDetail(
      {super.key, required this.recipeName}); // Soy un constructor :)

  @override
  State<RecipeDetail> createState() => _RecipeDetailState();
}

class _RecipeDetailState extends State<RecipeDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        toolbarHeight: 130, // Aumentamos la altura para dar más espacio
        title: Text(widget.recipeName,
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
      ),
    );
  }
}
