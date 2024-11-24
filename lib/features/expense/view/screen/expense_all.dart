import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/constant.dart';
import '../../../../core/utils/custom_textstyle.dart';
import '../../view_model/bloc/expense_bloc.dart';
import '../widget/custom_card.dart';
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

                      BlocProvider.of<ExpenseBloc>(context).add(
                          ExpenseFilterListEvent(
                              week: getWeekNumber(today), year: today.year));
                    },
                    child: const Text("Week")),
                TextButton(
                    onPressed: () {
                      DateTime now = DateTime.now();

                      BlocProvider.of<ExpenseBloc>(context).add(
                          ExpenseFilterListEvent(
                              month: now.month, year: now.year));
                    },
                    child: const Text("Month")),
                TextButton(
                    onPressed: () {
                      BlocProvider.of<ExpenseBloc>(context).add(
                          ExpenseFilterListEvent(year: DateTime.now().year));
                    },
                    child: const Text("Year")),
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
                          child: CustomCard(
                              image:
                                  iconList[state.expenseList[index].category!]!,
                              category: state.expenseList[index].category!,
                              description:
                                  state.expenseList[index].description!,
                              amount: state.expenseList[index].amount!,
                              date: state.expenseList[index].date!),
                          /*Card(
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
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Container(
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
                                            style:
                                                CustomTextStyle.titleTextStyle(
                                                    fontsize: 16),
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
                                                style: CustomTextStyle
                                                    .subTextStyle(
                                                        fontstyle:
                                                            FontStyle.normal)),
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
                                          "\u20B9${double.parse(state.expenseList[index].amount!).toStringAsFixed(2)}",
                                          style: CustomTextStyle.titleTextStyle(
                                              color: Colors.deepOrange),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20, right: 20),
                                        child: Text(
                                          state.expenseList[index].date!,
                                          style: CustomTextStyle.subTextStyle(),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),*/
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
