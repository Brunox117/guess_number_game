import 'package:flutter/material.dart';

class NumbersTable extends StatelessWidget {
  final List<int> numbersToShow;
  final String header;
  const NumbersTable({
    super.key,
    required this.numbersToShow,
    required this.header,
  });

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;
    return Column(
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
    );
  }
}
