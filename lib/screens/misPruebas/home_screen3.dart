import 'package:flutter/material.dart';

class HomeScreen3 extends StatelessWidget {
  const HomeScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 125,
      child: Card(
        child: Row(
          children: <Widget>[
            SizedBox(
              height: 125,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(),
              ),
            ),
            SizedBox(width: 26),
            Column(
              children: [
                Text('Lazaña'),
                Text('Pequitashh'),
                Container(
                  height: 2,
                  width: 75,
                  color: Colors.orange,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
