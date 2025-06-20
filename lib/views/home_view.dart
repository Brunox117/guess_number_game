import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String difficultyText = 'Fácil';
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
    if (sliderValue == 1) {
      numberToGuess = random.nextInt(10) + 1;
      triesLeft = 5;
      difficultyText = 'Fácil';
    } else if (sliderValue == 2) {
      numberToGuess = random.nextInt(20) + 1;
      triesLeft = 8;
      difficultyText = 'Medio';
    } else if (sliderValue == 3) {
      numberToGuess = random.nextInt(100) + 1;
      triesLeft = 15;
      difficultyText = 'Avanzado';
    } else if (sliderValue == 4) {
      numberToGuess = random.nextInt(1000) + 1;
      triesLeft = 25;
      difficultyText = 'Extremo';
    }
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
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            Text("Dificultad: $difficultyText"),
            Slider(
              value: sliderValue,
              min: 1.0,
              max: 4.0,
              divisions: 3,
              onChanged: (value) {
                setState(() {
                  sliderValue = value;
                  newGame();
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
