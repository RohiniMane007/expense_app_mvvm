import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/constant.dart';
import '../../view_model/bloc/expense_bloc.dart';
import 'add_expense.dart';

class ExpenseAll extends StatelessWidget {
  const ExpenseAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense List"),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () {
                      DateTime today = DateTime.now();

                      // Get the start of the current week (Monday)
                      DateTime startOfWeek =
                          getStartOfWeek(today).add(const Duration(days: 6));

                      print("week:${getWeekNumber(today)}");

                      BlocProvider.of<ExpenseBloc>(context).add(
                          ExpenseFilterListEvent(
                              week: getWeekNumber(today), year: today.year));
                    },
                    child: const Text("Week")),
                TextButton(
                    onPressed: () {
                      DateTime now = DateTime.now();

                      DateTime firstDayOfMonth =
                          DateTime(now.year, now.month, 1);

                      DateTime lastDayOfMonth =
                          DateTime(now.year, now.month + 1, 0);

                      print("$firstDayOfMonth - $lastDayOfMonth");
                    },
                    child: const Text("Month")),
                TextButton(onPressed: () {}, child: const Text("Year")),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text("Deleted")));
                        },
                        child: GestureDetector(
                          onDoubleTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return BlocProvider.value(
                                value: BlocProvider.of<ExpenseBloc>(context),
                                child: AddExpense(
                                  id: state.expenseList[index].id,
                                  amount: state.expenseList[index].amount,
                                  description:
                                      state.expenseList[index].description,
                                  date: state.expenseList[index].date,
                                  category: state.expenseList[index].category,
                                ),
                              );
                            }));
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DateTime getStartOfWeek(DateTime date) {
  // Get the difference from Monday
  int difference = date.weekday - DateTime.monday;

  // Adjust the date to get Monday of the current week
  return date.subtract(Duration(days: difference));
}

int getWeekNumber(DateTime date) {
  DateTime firstDayOfYear = DateTime(date.year, 1, 1);

  // Calculate the difference in days between the current date and the first day of the year
  int daysDifference = date.difference(firstDayOfYear).inDays;

  // Calculate the week number
  int weekNumber =
      (daysDifference / 7).floor() + 1; // Adding 1 because week starts from 1

  return weekNumber;
}
