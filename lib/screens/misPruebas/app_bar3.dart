import 'package:flutter/material.dart';

class AppBarTemplate extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.orange[400],
      toolbarHeight: 130, // Aumentamos la altura para dar más espacio
      title: Padding(
        padding:
            const EdgeInsets.only(top: 15), // Más espacio en la parte superior
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alineación izquierda
          mainAxisSize: MainAxisSize
              .min, // Evita que Column ocupe más espacio del necesario
          children: [
            const Text(
              'Recipe Book',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22, // Tamaño del título un poco mayor
              ),
            ),
            const SizedBox(
                height: 30), // Mucho más espacio entre el título y los iconos
            Row(
              children: [
                _iconWithText(Icons.home, 'Home'),
                const SizedBox(width: 100), // Más espacio entre los iconos
                _iconWithText(Icons.favorite, 'Favorites'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Función para crear un icono con su texto debajo
  Widget _iconWithText(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize
          .min, // Evita que los iconos ocupen más espacio del necesario
      children: [
        IconButton(
          icon: Icon(icon),
          iconSize: 28, // Tamaño del icono más grande
          color: Colors.white,
          onPressed: () {},
        ),
        Text(
          label,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold), // Texto más grande
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      160); // Ajustamos la altura para acomodar los cambios
}
