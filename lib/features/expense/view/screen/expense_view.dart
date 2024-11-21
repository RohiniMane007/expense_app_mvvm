import 'package:expense_app/features/expense/view/widget/legend.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.tealAccent),
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PieChart(PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: [
                        PieChartSectionData(

                            // titlePositionPercentageOffset: 70,
                            // title: 'type1',
                            value: 10,
                            color: Colors.blue),
                        PieChartSectionData(
                            // title: 'type2',
                            value: 30,
                            color: Colors.yellow),
                        PieChartSectionData(
                            // title: 'type3',
                            value: 10,
                            color: Colors.deepOrange)
                      ])),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LegendsListWidget(
                        legends: [
                          LegendData("name", Colors.red),
                          LegendData("name", Colors.yellow),
                          LegendData("name", Colors.orange),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("Recents"),
              ),
              // ElevatedButton(onPressed: () {}, child: const Text("Week")),
              // ElevatedButton(onPressed: () {}, child: const Text("Month")),
              TextButton(onPressed: () {}, child: const Text("See All >"))
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(color: Colors.amber),
            width: MediaQuery.sizeOf(context).width,
            height: 250,
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: 2,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  shadowColor: Colors.orange,
                  color: Colors.white,
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    padding: const EdgeInsets.only(right: 10),
                    height: 100,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Icon(Icons.home),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(
                                "category",
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: SizedBox(
                                width: 50,
                                child: Text(
                                  "description",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              " ₹ data",
                            ),
                            Text(
                              "sub",
                            )
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     IconButton(
                        //         onPressed: () async {},
                        //         icon: const Icon(Icons.edit)),
                        //   ],
                        // )
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
