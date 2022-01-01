// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
    required this.label,
    required this.value,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'R\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 13,
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: null,
        ),
        SizedBox(height: 5),
        Text(label),
      ],
    );
  }
}
