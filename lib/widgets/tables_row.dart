import 'package:flutter/material.dart';
import 'package:guess_number_game/model/winning_numbers.dart';
import 'package:guess_number_game/widgets/numbers_table.dart';
import 'package:guess_number_game/widgets/winning_numbers_table.dart';

class TablesRow extends StatelessWidget {
  const TablesRow({
    super.key,
    required this.moreThanList,
    required this.lessThanList,
    required this.winningList,
  });

  final List<int> moreThanList;
  final List<int> lessThanList;
  final List<WinningNumbers> winningList;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NumbersTable(numbersToShow: moreThanList, header: "Mayor que"),
        NumbersTable(numbersToShow: lessThanList, header: "Menor que"),
        WinningNumbersTable(numbersToShow: winningList, header: "Adivinados"),
      ],
    );
  }
}
