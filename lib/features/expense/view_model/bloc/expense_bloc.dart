import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_app/features/expense/model/model.dart';

import '../../../../core/db/database_helper.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  ExpenseBloc() : super(const ExpenseState()) {
    // on<ExpenseEvent>((event, emit) {});

    on<ExpenseListEvent>(_listExpense);
    on<ExpenseAddEvent>(_addExpense);
    on<ExpenseUpdateEvent>(_updateExpense);
    on<ExpenseDeleteEvent>(_deleteExpense);
  }

  void _listExpense(event, emit) async {
    await ExpenseService.deleteItem(await databaseHelper.database, 15);
    List<Map<String, dynamic>> res =
        await ExpenseService.getItems(await databaseHelper.database);

    List<Expense> expenseList =
        res.map((item) => Expense.fromJson(item)).toList();

    emit(state.copyWith(expenseList: expenseList));
  }

  void _addExpense(ExpenseAddEvent event, Emitter<ExpenseState> emit) async {
    await ExpenseService.insertItem(
        await databaseHelper.database,
        Expense(
            category: event.category,
            amount: event.amount,
            date: event.date,
            description: event.description));

    List<Map<String, dynamic>> res =
        await ExpenseService.getItems(await databaseHelper.database);

    List<Expense> expenseList =
        res.map((item) => Expense.fromJson(item)).toList();
    print(expenseList);
    emit(state.copyWith(expenseList: expenseList));
  }

  void _updateExpense(
      ExpenseUpdateEvent event, Emitter<ExpenseState> emit) async {
    await ExpenseService.updateItem(
        await databaseHelper.database, event.expense);

    List<Map<String, dynamic>> res =
        await ExpenseService.getItems(await databaseHelper.database);

    List<Expense> expenseList =
        res.map((item) => Expense.fromJson(item)).toList();

    emit(state.copyWith(expenseList: expenseList));
  }

  void _deleteExpense(
      ExpenseDeleteEvent event, Emitter<ExpenseState> emit) async {
    await ExpenseService.deleteItem(await databaseHelper.database, event.id);
    List<Map<String, dynamic>> res =
        await ExpenseService.getItems(await databaseHelper.database);

    List<Expense> expenseList =
        res.map((item) => Expense.fromJson(item)).toList();

    emit(state.copyWith(expenseList: expenseList));
  }
}
