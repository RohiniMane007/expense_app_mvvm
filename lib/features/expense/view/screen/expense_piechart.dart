import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/bloc/expense_bloc.dart';
import '../widget/legend.dart';

class ExpensePiechart extends StatelessWidget {
  const ExpensePiechart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  return PieChart(PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(value: 30, color: Colors.green),
                        PieChartSectionData(value: 30, color: Colors.yellow),
                        PieChartSectionData(value: 15, color: Colors.blue),
                        PieChartSectionData(value: 10, color: Colors.red),
                        PieChartSectionData(value: 5, color: Colors.brown),
                        PieChartSectionData(
                            value: 10, color: Colors.lightBlue[200])
                      ]));
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LegendsListWidget(
                    legends: [
                      LegendData("Education", Colors.green),
                      LegendData("Food", Colors.yellow),
                      LegendData("Transport", Colors.red),
                      LegendData("Health", Colors.blue),
                      LegendData("Housing", Colors.brown),
                      LegendData("other", Colors.blueGrey),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
