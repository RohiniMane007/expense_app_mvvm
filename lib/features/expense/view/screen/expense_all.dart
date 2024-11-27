import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../comman/shared_widget/custom_appbar.dart';
import '../../../../core/utils/constant.dart';
import '../../view_model/bloc/expense_bloc.dart';
import '../widget/custom_card.dart';
import 'add_update_expense.dart';

class ExpenseAll extends StatelessWidget {
  const ExpenseAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Expense List",
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
                        height: 15,
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
                                child: AddUpdateExpense(
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
