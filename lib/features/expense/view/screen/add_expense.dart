import 'package:flutter/material.dart';

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
    return Material(
      type: MaterialType.card,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 30),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: DropdownMenu<String>(
                    expandedInsets: const EdgeInsets.symmetric(),
                    label: const Text("Category"),
                    onSelected: (String? value) {
                      categoryValue = value!;
                    },
                    dropdownMenuEntries: const []),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                  controller: txtAmount,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                  )),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: TextField(
                controller: txtDescription,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
            )),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
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
                onTap: () async {},
              ),
            )),
            Expanded(
                child: Padding(
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
            ))
          ],
        ),
      ),
    );
  }
}
