import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recetas_app/app_bar.dart';
import 'package:recetas_app/providers/recipes_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipesProvider()),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: RecipeBook()),
    );
  }
}
