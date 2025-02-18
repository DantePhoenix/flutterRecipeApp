import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Importar dotenv
import 'package:provider/provider.dart';
import 'package:recetas_app/app_bar.dart';
import 'package:recetas_app/providers/recipes_provider.dart';

//Es necesaria este tipo de estructura para la primera parte del main
// para que se puedan usar variables de entorno
Future<void> main() async { // tiene que ser asíncrono
// asegurarse de que el framework está correctamente inicializado antes de ejecutar ciertas operaciones en el main()
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Cargar variables del archivo .env

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RecipeBook(),
      ),
    );
  }
}
