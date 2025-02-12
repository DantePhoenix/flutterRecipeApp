import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        _recipesCard(context),
        _recipesCard(context),
        FloatingActionButton(
          onPressed: () {
            _showBottom(context);
          },
          backgroundColor: Colors.orange[400],
          child: Icon(Icons.add, color: Colors.white),
        ),
      ],
    ));
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

  Widget _recipesCard(BuildContext context) {
    return Padding(
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
                  child: Image.asset(
                    'assets/images/lasagna.jpg',
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
                    'Lasagna',
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
                  Text('Alison J',
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
    );
  }



//Formulario para crear la receta
class RecipeForm extends StatelessWidget {
  const RecipeForm({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>(); // almacena el estado del formulario en una key

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


