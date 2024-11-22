// import 'package:expense_app/features/expense/view/screen/expense_manager.dart';
import 'package:expense_app/features/expense/view_model/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant.dart';

class AddExpense extends StatefulWidget {
  const AddExpense(
      {super.key,
      this.id,
      this.amount,
      this.description,
      this.date,
      this.category});
  final String? amount, description, date, category;
  final int? id;
  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController category = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // widget.id ?? 0;
    txtAmount.text = widget.amount ?? "";
    txtDescription.text = widget.description ?? "";
    txtDate.text = widget.date ?? "";
    category.text = widget.category ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    txtAmount.dispose();
    txtDescription.dispose();
    txtDate.dispose();
    category.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // type: MaterialType.card,
        body: Center(
            child: SizedBox(
                width: 300,
                height: 600,
                child: Form(
                  key: formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: DropdownMenu<String>(
                                controller: category,
                                expandedInsets: const EdgeInsets.symmetric(),
                                label: const Text("Category"),
                                onSelected: (String? value) {
                                  // categoryValue = value!;
                                },
                                dropdownMenuEntries: categoryList
                                    .map<DropdownMenuEntry<String>>(
                                        (String value) {
                                  return DropdownMenuEntry<String>(
                                      value: value, label: value);
                                }).toList())),
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextFormField(
                                controller: txtAmount,
                                validator: (value) {
                                  return (value != null && value.isEmpty)
                                      ? 'Enter amount'
                                      : null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                  border: OutlineInputBorder(),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextFormField(
                            controller: txtDescription,
                            validator: (value) {
                              return (value != null && value.isEmpty)
                                  ? 'Enter description'
                                  : null;
                            },
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextFormField(
                                    controller: txtDate,
                                    validator: (value) {
                                      return (value != null && value.isEmpty)
                                          ? 'Enter date'
                                          : null;
                                    },
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Date',
                                      prefixIcon: Icon(
                                        Icons.calendar_month_sharp,
                                        color: Color(0XFF01579b),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    onTap: () async {
                                      DateTime? picked =
                                          await dateTimePicker(context);
                                      setState(() {
                                        txtDate.text =
                                            picked.toString().split(' ')[0];
                                      });
                                    }))),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          foregroundColor: Colors.white),
                                      onPressed: () {
                                        BlocProvider.of<ExpenseBloc>(context)
                                            .add(ExpenseListEvent());
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Cancel")),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          foregroundColor: Colors.white),
                                      child: Text(
                                          widget.id == null ? "Add" : "Update"),
                                      onPressed: () async {
                                        // BlocProvider.of<ExpenseBloc>(context)
                                        //     .add(ExpenseAddEvent(
                                        //         category: category.text,
                                        //         amount: txtAmount.text,
                                        //         description:
                                        //             txtDescription.text,
                                        //         date: txtDate.text));
                                        String? res = await showAdaptiveDialog<
                                                String>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: const Text(
                                                    "Successfully Added"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop("ok");
                                                      },
                                                      child: const Text("OK"))
                                                ],
                                              );
                                            });

                                        if (res == 'ok') {
                                          if (!context.mounted) return;
                                          category.clear();
                                          txtAmount.clear();
                                          txtDescription.clear();
                                          txtDate.clear();
                                          // Navigator.of(context).pop();
                                        }
                                      })
                                ]))
                      ]),
                ))));
  }
}
