import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adivina el número')),

      body: Padding(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Ingresa un número",
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      print("value -> $value");
                    },
                  ),
                ),

                const SizedBox(width: 30),

                Column(children: [const Text("Intentos restantes"), Text("1")]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
