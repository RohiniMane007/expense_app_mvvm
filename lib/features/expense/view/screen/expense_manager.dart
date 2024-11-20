import 'package:flutter/material.dart';

import '../../model/models/expense_model.dart';

class ExpenseManager extends InheritedWidget {
  final List<Expense> expenses;
  final void Function(Expense expense) addExpense;
  final void Function(int index, Expense expense) updateExpense;

  const ExpenseManager({
    super.key,
    required this.expenses,
    required this.addExpense,
    required this.updateExpense,
    required super.child,
  });

  static ExpenseManager of(BuildContext context) {
    final ExpenseManager? result =
        context.dependOnInheritedWidgetOfExactType<ExpenseManager>();
    assert(result != null, 'No ExpenseManager found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ExpenseManager oldWidget) {
    return expenses != oldWidget.expenses;
  }
}

class ExpenseHomePage extends StatelessWidget {
  const ExpenseHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final expenseManager = ExpenseManager.of(context);
    // expenseManager.expenses =

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: ListView.builder(
        itemCount: expenseManager.expenses.length,
        itemBuilder: (context, index) {
          final expense = expenseManager.expenses[index];
          return ListTile(
            title: Text(expense.description!),
            subtitle: Text('${expense.amount} - ${expense.date!}'),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showExpenseDialog(context, expenseManager,
                  expense: expense, index: index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showExpenseDialog(context, expenseManager),
      ),
    );
  }

  void _showExpenseDialog(BuildContext context, ExpenseManager manager,
      {Expense? expense, int? index}) {
    final amountController = TextEditingController(
        text: expense != null ? expense.amount.toString() : '');
    final descriptionController =
        TextEditingController(text: expense != null ? expense.description : '');
    DateTime selectedDate = DateTime.parse(expense!.date!) ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 10),
              TextButton(
                child: Text('Select Date: ${selectedDate.toLocal()}'),
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text) ?? 0.0;
                final description = descriptionController.text;

                if (expense == null) {
                  manager.addExpense(Expense(
                      category: "",
                      amount: amount.toString(),
                      description: description,
                      date: "selectedDate"));
                } else {
                  manager.updateExpense(
                      index!,
                      Expense(
                          category: "",
                          amount: "amount",
                          description: description,
                          date: "selectedDate"));
                }

                Navigator.of(context).pop();
              },
              child: Text(expense == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}

class ExpenseApp extends StatefulWidget {
  const ExpenseApp({super.key});

  @override
  _ExpenseAppState createState() => _ExpenseAppState();
}

class _ExpenseAppState extends State<ExpenseApp> {
  final List<Expense> _expenses = [
    const Expense(
        category: "category",
        amount: "amount",
        date: "2012-02-01",
        description: "description"),
    const Expense(
        category: "category",
        amount: "amount",
        date: "2012-02-01",
        description: "description"),
    const Expense(
        category: "category",
        amount: "amount",
        date: "2012-02-01",
        description: "description"),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _updateExpense(int index, Expense expense) {
    setState(() {
      _expenses[index] = expense;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExpenseManager(
      expenses: _expenses,
      addExpense: _addExpense,
      updateExpense: _updateExpense,
      child: const MaterialApp(
        home: ExpenseHomePage(),
      ),
    );
  }
}
