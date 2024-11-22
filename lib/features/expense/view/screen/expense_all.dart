import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant.dart';
import '../../view_model/bloc/expense_bloc.dart';

class ExpenseAll extends StatelessWidget {
  const ExpenseAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense List"),
      ),
      body: Container(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount:
                  state.expenseList.length >= 4 ? 4 : state.expenseList.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(state.expenseList[index].toString()),
                  onDismissed: (direction) {
                    BlocProvider.of<ExpenseBloc>(context).add(
                        ExpenseDeleteEvent(id: state.expenseList[index].id!));
                    // state.expenseList.removeAt(index);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text("Deleted")));
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
                                  child: Image.asset(iconList[
                                      state.expenseList[index].category!]!)),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    state.expenseList[index].category!,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: SizedBox(
                                    width: 50,
                                    child: Text(
                                      state.expenseList[index].description!,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, right: 20),
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
    );
  }
}
