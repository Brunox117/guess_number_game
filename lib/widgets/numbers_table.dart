import 'package:flutter/material.dart';

class NumbersTable extends StatelessWidget {
  final List<int> numbersToShow;
  final String header;
  final double width;
  const NumbersTable({
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
              ...numbersToShow.map((number) {
                return Text("$number");
              }),
            ],
          ),
        ],
      ),
    );
  }
}
