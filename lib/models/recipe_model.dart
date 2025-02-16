// ignore_for_file: non_constant_identifier_names

// El modelo define los atributos que un conjunto de datos debe tener
// en este caso se definen los atributos de: nombre author, imagen y receta

// La creación del modelo es necesario para la creación del Provider

class Recipe {
  //Definir la estructura del modelo
  int id;
  String name;
  String author;
  String image_link;
  List<String> recipeSteps;

  //Definir el constructor del modelo
  Recipe({
    required this.id,
    required this.name,
    required this.author,
    required this.image_link,
    required this.recipeSteps,
  });

  // Definir el factory para un manejo correcto del estado (estructura de la respuesta)
  // Ver estructura de la respuesta de la Api
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id:json['id'],
      name: json['name'],
      author: json['author'],
      image_link: json['image_link'],
      recipeSteps: List<String>.from(json['recipe']),
    );
  }

  // Convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'image_link': image_link,
      'recipe': recipeSteps
    };
  }

//No es obligatorio, pero es muy util para hacer debugging
  @override
  String toString() {
    return 'Recipe{id: $id, name: $name, author: $author, image_link: $image_link, recipe: $recipeSteps}';
  }
}
