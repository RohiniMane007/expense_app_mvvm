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
  // TextEditingController txtDate = TextEditingController();
  String categoryValue = '';
  DateTime selectedDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();
    txtAmount.dispose();
    txtDescription.dispose();
    // txtDate.dispose();
    categoryValue = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // type: MaterialType.card,
      body: Container(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: DropdownMenu<String>(
                  expandedInsets: const EdgeInsets.symmetric(),
                  label: const Text("Category"),
                  onSelected: (String? value) {
                    categoryValue = value!;
                  },
                  dropdownMenuEntries:
                      category.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(
                        value: value, label: value);
                  }).toList()),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                  controller: txtAmount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  )),
            ),
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
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  child: Text(
                    'Select Date: ${selectedDate.toLocal()}',
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  onPressed: () async {
                    DateTime? picked = await dateTimePicker(context);
                    if (picked != null) {
                      selectedDate = picked;
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text("Add"),
                    onPressed: () async {
                      String? res = await showAdaptiveDialog<String>(
                          context: context,
                          builder: (context) {
                            return AlertDialog.adaptive(
                              title: const Text("Successfully Added"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop("ok");
                                    },
                                    child: const Text("OK"))
                              ],
                            );
                          });

                      if (res == 'ok') {
                        if (!context.mounted) return;
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
