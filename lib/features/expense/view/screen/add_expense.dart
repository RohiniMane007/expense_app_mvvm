// import 'package:expense_app/features/expense/view/screen/expense_manager.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constant.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController txtAmount = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  String categoryValue = '';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    txtAmount.dispose();
    txtDescription.dispose();
    txtDate.dispose();
    categoryValue = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // type: MaterialType.card,
        body: Center(
            child: Container(
                // alignment: Alignment.center,
                width: 300,
                height: 600,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownMenu<String>(
                              expandedInsets: const EdgeInsets.symmetric(),
                              label: const Text("Category"),
                              onSelected: (String? value) {
                                categoryValue = value!;
                              },
                              dropdownMenuEntries: category
                                  .map<DropdownMenuEntry<String>>(
                                      (String value) {
                                return DropdownMenuEntry<String>(
                                    value: value, label: value);
                              }).toList())),
                      Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                              controller: txtAmount,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Amount',
                                border: OutlineInputBorder(),
                              ))),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: txtDescription,
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
                              child: TextField(
                                  controller: txtDate,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white),
                                    onPressed: () {},
                                    child: const Text("Cancel")),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.teal,
                                        foregroundColor: Colors.white),
                                    child: const Text("Add"),
                                    onPressed: () async {
                                      String? res =
                                          await showAdaptiveDialog<String>(
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
                                        Navigator.of(context).pop();
                                      }
                                    })
                              ]))
                    ]))));
  }
}
