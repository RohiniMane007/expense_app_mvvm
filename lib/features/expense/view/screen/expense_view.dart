import 'package:expense_app/features/expense/view/screen/add_update_expense.dart';
import 'package:expense_app/features/expense/view/widget/custom_card.dart';
import 'package:expense_app/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../comman/shared_widget/custom_appbar.dart';
import '../../../../core/utils/constant.dart';
import '../../view_model/bloc/expense_bloc.dart';
import 'expense_list.dart';

class ExpenseView extends StatelessWidget {
  final String? username;
  const ExpenseView({super.key, this.username});

  @override
  Widget build(BuildContext context) {
    // print("==========$username");
    // BlocProvider.of<ExpenseBloc>(context).add(ExpenseListEvent());
    return Scaffold(
        appBar: CustomAppBar(
          title: "Home",
          username: username,
        ),
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
                padding: const EdgeInsets.all(30),
                width: MediaQuery.sizeOf(context).width,
                height: 220,
                child: BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    return AnimatedContainer(
                      curve: Curves.bounceIn,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.1),
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 2, 90, 81),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.teal, //.withOpacity(0.5),
                              spreadRadius: 5,
                              // blurRadius: 10,
                              offset: Offset(5, 5),
                            )
                          ]),
                      duration: const Duration(seconds: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Expense",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "\u20B9 ${state.expenseList.fold<double>(0, (sum, item) => sum + double.parse(item.amount.toString())).toStringAsFixed(2)}",
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  },
                )
                /* Row(
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
                            PieChartSectionData(
                                value: 30, color: Colors.yellow),
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
            ),*/
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text("Recents"),
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, RouteName.expenseList,
                      //     arguments: {"username": username});
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return BlocProvider.value(
                          value: BlocProvider.of<ExpenseBloc>(context)
                            ..add(ExpenseListEvent()),
                          child: const ExpenseList(),
                        );
                      }));
                    },
                    child: const Text("See All >>"))
              ],
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 20),
                // decoration: const BoxDecoration(color: Colors.amber),
                width: MediaQuery.sizeOf(context).width,
                child: BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (context, state) {
                    return state.expenseList.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 15,
                              );
                            },
                            itemCount: state.expenseList.length >= 3
                                ? 3
                                : state.expenseList.length,
                            itemBuilder: (context, index) {
                              return Dismissible(
                                  key: Key(state.expenseList[index].toString()),
                                  onDismissed: (direction) {
                                    BlocProvider.of<ExpenseBloc>(context).add(
                                        ExpenseDeleteEvent(
                                            id: state.expenseList[index].id!));
                                    // state.expenseList.removeAt(index);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Deleted")));
                                  },
                                  child: CustomCard(
                                      image: iconList[
                                          state.expenseList[index].category!]!,
                                      category:
                                          state.expenseList[index].category!,
                                      description:
                                          state.expenseList[index].description!,
                                      amount: state.expenseList[index].amount!,
                                      date: state.expenseList[index].date!));
                            },
                          )
                        : const Text(
                            "Empty List",
                            textAlign: TextAlign.center,
                          );
                  },
                ),
              ),
            )
          ],
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.orange,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return BlocProvider.value(
                value: BlocProvider.of<ExpenseBloc>(context),
                child: const AddUpdateExpense(),
              );
            }));
          },
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5.0,
          clipBehavior: Clip.antiAlias,
          color: Colors.teal,
          child: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon:
                      const Icon(Icons.pie_chart_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
