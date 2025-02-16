import 'package:flutter/material.dart';
import 'package:recetas_app/screens/details_screen.dart';
import 'package:recetas_app/screens/home_screen.dart';

class RecipeBook extends StatelessWidget {
  const RecipeBook({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              'Recipe Book',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
              ),
            ),
            bottom: TabBar(
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(
                    icon: Icon(Icons.home),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(Icons.favorite),
                    text: 'Favorites',
                  )
                ]),
          ),
          body: TabBarView(children: [HomeScreen(), FavoritesScreen()])),
    );
  }
}
