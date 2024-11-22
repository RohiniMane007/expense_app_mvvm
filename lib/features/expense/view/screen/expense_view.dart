import 'package:expense_app/features/expense/view/screen/add_expense.dart';
import 'package:expense_app/features/expense/view/widget/legend.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constant.dart';
import '../../view_model/bloc/expense_bloc.dart';

class ExpenseView extends StatelessWidget {
  const ExpenseView({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ExpenseBloc>(context).add(ExpenseListEvent());
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
                        PieChartSectionData(value: 40, color: Colors.green),
                        PieChartSectionData(value: 30, color: Colors.yellow),
                        PieChartSectionData(value: 15, color: Colors.blue),
                        PieChartSectionData(value: 10, color: Colors.red),
                        PieChartSectionData(value: 5, color: Colors.brown),
                        PieChartSectionData(
                            value: 10, color: Colors.lightBlue[200])
                      ])),
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
              child: BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  return ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: state.expenseList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: Key(state.expenseList[index].toString()),
                        onDismissed: (direction) {
                          BlocProvider.of<ExpenseBloc>(context).add(
                              ExpenseDeleteEvent(
                                  id: state.expenseList[index].id!));
                          // state.expenseList.removeAt(index);

                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Deleted")));
                        },
                        child: Card(
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
                                    child: CircleAvatar(
                                        child: Image.asset(iconList[state
                                            .expenseList[index].category!]!)),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          state.expenseList[index].category!,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: SizedBox(
                                          width: 50,
                                          child: Text(
                                            state.expenseList[index]
                                                .description!,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 20),
                                      child: Text(
                                        state.expenseList[index].amount!,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20, right: 20),
                                      child: Text(
                                        state.expenseList[index].date!,
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
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return BlocProvider.value(
              value: BlocProvider.of<ExpenseBloc>(context),
              child: const AddExpense(),
            );
          }));
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
