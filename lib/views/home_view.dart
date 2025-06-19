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
  int numberToGues = 5;
  List<int> moreThanList = [];
  List<int> lessThanList = [];
  List<int> winningList = [];
  TextEditingController controller = TextEditingController();
  String? errorText;

  void onSubmit() {
    print("currentNumber -> $currentNumber");
    int? x = int.tryParse(currentNumber);
    if (x != null) {
      if (x > numberToGues) {
        lessThanList.add(x);
      } else if (x < numberToGues) {
        moreThanList.add(x);
      } else {
        winningList.add(x);
      }
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NumbersTable(numbersToShow: moreThanList, header: "Mayor que"),
                NumbersTable(numbersToShow: lessThanList, header: "Menor que"),
                NumbersTable(numbersToShow: winningList, header: "Adivinados"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
