// import 'package:expense_app/features/expense/view/screen/expense_manager.dart';
import 'package:expense_app/features/expense/view_model/bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/constant.dart';

class AddUpdateExpense extends StatefulWidget {
  const AddUpdateExpense(
      {super.key,
      this.id,
      this.amount,
      this.description,
      this.date,
      this.category});
  final String? amount, description, date, category;
  final int? id;
  @override
  State<AddUpdateExpense> createState() => _AddUpdateExpenseState();
}

class _AddUpdateExpenseState extends State<AddUpdateExpense> {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController category = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // widget.id ?? 0;
    txtAmount.text = widget.amount ?? "";
    txtDescription.text = widget.description ?? "";
    txtDate.text = widget.date ?? DateTime.now().toString().split(' ')[0];
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
        body: Center(
            child: SizedBox(
                width: 400,
                height: 600,
                child: Form(
                  key: formKey,
                  child: ListView(children: [
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: TextFormField(
                            controller: txtAmount,
                            validator: (value) {
                              return (value == null || value.isEmpty)
                                  ? 'Enter amount'
                                  : null;
                            },
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                              border: OutlineInputBorder(),
                            ))),
                    Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: DropdownMenu<String>(
                            controller: category,
                            expandedInsets: const EdgeInsets.symmetric(),
                            label: const Text("Category"),
                            onSelected: (String? value) {
                              // categoryValue = value!;
                            },
                            dropdownMenuEntries: categoryList
                                .map<DropdownMenuEntry<String>>((String value) {
                              return DropdownMenuEntry<String>(
                                  value: value, label: value);
                            }).toList())),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 30, left: 10, right: 10),
                      child: TextFormField(
                        controller: txtDescription,
                        validator: (value) {
                          return (value == null || value.isEmpty)
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
                        padding:
                            const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: TextFormField(
                            controller: txtDate,
                            validator: (value) {
                              return (value == null || value.isEmpty)
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
                              DateTime? picked = await dateTimePicker(context);
                              // setState(() {
                              txtDate.text = picked.toString().split(' ')[0];
                              // });
                            })),
                    Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white),
                                    onPressed: () {
                                      BlocProvider.of<ExpenseBloc>(context)
                                          .add(ExpenseListEvent());
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel")),
                              ),
                              SizedBox(
                                width: 100,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white),
                                    child: Text(
                                        widget.id == null ? "Add" : "Update"),
                                    onPressed: () async {
                                      if (formKey.currentState!.validate() &&
                                          category.text != "") {
                                        widget.id == null
                                            ? BlocProvider.of<ExpenseBloc>(
                                                    context)
                                                .add(ExpenseAddEvent(
                                                    category: category.text,
                                                    amount: txtAmount.text,
                                                    description:
                                                        txtDescription.text,
                                                    date: txtDate.text))
                                            : BlocProvider.of<ExpenseBloc>(
                                                    context)
                                                .add(ExpenseUpdateEvent(
                                                    id: widget.id!,
                                                    category: category.text,
                                                    amount: txtAmount.text,
                                                    description:
                                                        txtDescription.text,
                                                    date: txtDate.text));
                                        String? res = await showAdaptiveDialog<
                                                String>(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog.adaptive(
                                                title: Text(widget.id == null
                                                    ? "Successfully Added"
                                                    : "Successfully Updated"),
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

                                          if (widget.id != null) {
                                            Navigator.of(context).pop();
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: Colors.red,
                                                content:
                                                    Text("Select Category")));
                                      }
                                    }),
                              )
                            ]))
                  ]),
                ))));
  }
}
