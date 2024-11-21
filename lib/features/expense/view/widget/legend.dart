import 'package:flutter/material.dart';

class Legend extends StatelessWidget {
  const Legend({
    super.key,
    required this.name,
    required this.color,
  });
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          name,
          style: const TextStyle(
            color: Color(0xff757391),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class LegendsListWidget extends StatelessWidget {
  const LegendsListWidget({
    super.key,
    required this.legends,
  });
  final List<LegendData> legends;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      spacing: 10,
      children: legends
          .map(
            (e) => Legend(
              name: e.name,
              color: e.color,
            ),
          )
          .toList(),
    );
  }
}

class LegendData {
  LegendData(this.name, this.color);
  final String name;
  final Color color;
}
