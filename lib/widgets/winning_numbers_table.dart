import 'package:flutter/material.dart';
import 'package:guess_number_game/model/winning_numbers.dart';

class WinningNumbersTable extends StatelessWidget {
  final List<WinningNumbers> numbersToShow;
  final String header;
  final double width;
  const WinningNumbersTable({
    super.key,
    required this.numbersToShow,
    required this.header,
    this.width = 0.3,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
      child: Column(
        children: [
          Text(header, style: textStyles.bodyLarge),
          Column(
            children: [
              ...numbersToShow.map((winningNumber) {
                return Text(
                  "${winningNumber.winningNumber}",
                  style: TextStyle(
                    color: (winningNumber.isWinner) ? Colors.green : Colors.red,
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
