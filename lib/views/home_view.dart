import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_number_game/model/winning_numbers.dart';
import 'package:guess_number_game/widgets/tables_row.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  int triesLeft = 0;
  String currentNumber = '';
  int numberToGuess = 5;
  int maxNumber = 10;
  double sliderValue = 1;
  List<int> moreThanList = [];
  List<int> lessThanList = [];
  List<WinningNumbers> winningList = [];
  TextEditingController controller = TextEditingController();
  String? errorText;

  @override
  void initState() {
    super.initState();
    newGame();
  }

  void newGame() {
    final random = Random();
    numberToGuess = random.nextInt(maxNumber) + 1;
    print("numberToGuess -> $numberToGuess");
    triesLeft = 5;
    moreThanList.clear();
    lessThanList.clear();
    setState(() {});
  }

  void onSubmit() {
    int? x = int.tryParse(currentNumber);
    if (x != null) {
      checkNumber(x);
      setState(() {
        errorText = null;
        controller.clear();
        currentNumber = '';
      });
    } else {
      setState(() {
        errorText = "Porfavor, ingresa un número";
        controller.clear();
        currentNumber = '';
      });
    }
  }

  void checkNumber(int x) {
    if (numberToGuess == x) {
      winningList.add(WinningNumbers(winningNumber: x, isWinner: true));
      newGame();
      return;
    }
    triesLeft--;
    if (triesLeft == 0) {
      winningList.add(WinningNumbers(winningNumber: x, isWinner: false));
      newGame();
    } else {
      if (x > numberToGuess) {
        lessThanList.add(x);
      } else if (x < numberToGuess) {
        moreThanList.add(x);
      }
    }
  }

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
                    onTapOutside: (_) => FocusScope.of(context).unfocus(),
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "Ingresa un número",
                      border: OutlineInputBorder(),
                      errorText: errorText,
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      currentNumber = value;
                    },
                    onSubmitted: (_) => onSubmit(),
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
            ElevatedButton(
              onPressed: () => onSubmit(),
              child: Text("Adivinar"),
            ),
            SizedBox(height: 10),
            Text("Dificultad: Fácil"),
            Slider(
              value: sliderValue,
              min: 1.0,
              max: 4.0,
              divisions: 3,
              onChanged: (value) {
                print("sliderValue -> $value");
                setState(() {
                  sliderValue = value;
                });
              },
            ),
            SizedBox(height: 10),
            TablesRow(
              moreThanList: moreThanList,
              lessThanList: lessThanList,
              winningList: winningList,
            ),
          ],
        ),
      ),
    );
  }
}
