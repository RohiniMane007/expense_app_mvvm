import 'package:expense_app/features/expense/view/screen/add_expense.dart';
import 'package:expense_app/features/expense/view/widget/legend.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Monthly Expense"),
              Text(DateFormat('MMMM').format(DateTime.now()))
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.tealAccent),
            width: MediaQuery.sizeOf(context).width,
            height: 200,
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
              TextButton(onPressed: () {}, child: const Text("See All >"))
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              decoration: const BoxDecoration(color: Colors.amber),
              width: MediaQuery.sizeOf(context).width,
              // height: 250,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: 5,
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
                      height: 80,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              // padding: const EdgeInsets.only(left: 10),
                              width: 35,
                              height: 35,
                              child:
                                  const CircleAvatar(child: Icon(Icons.home)),
                            ),
                          ),
                          const Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    "Educatiom",
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
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 10, right: 20),
                                child: Text(
                                  "100000",
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20, right: 20),
                                child: Text(
                                  "sub",
                                ),
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
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddExpense();
          }));
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
