import 'package:flutter/material.dart';
import 'package:guess_number_game/widgets/numbers_table.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int triesLeft = 5;
  String currentNumber = '';

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
                      currentNumber = value;
                    },
                  ),
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    const Text("Intentos restantes"),
                    Text("$triesLeft"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: NumbersTable(
                    numbersToShow: [1, 2, 3, 4],
                    header: "Mayor que",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: NumbersTable(
                    numbersToShow: [6, 7, 8, 9],
                    header: "Menor que",
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: NumbersTable(numbersToShow: [5], header: "Adivinados"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
