import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_app/features/expense/model/model.dart';

import '../../../../core/db/database_helper.dart';
import '../../../../core/utils/constant.dart';

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
    on<ExpenseFilterListEvent>(_filterExpense);
  }

  void _listExpense(ExpenseListEvent event, Emitter<ExpenseState> emit) async {
    // await ExpenseService.deleteItem(await databaseHelper.database, 17);
    List<Map<String, dynamic>> res =
        await ExpenseService.getItems(await databaseHelper.database);
    List<Expense> expenseList =
        res.map((item) => Expense.fromJson(item)).toList();

    List<Map<String, double>> ratio = [];
    categoryList.map((i) {
      double totalExpense = expenseList.fold(
          0, (sum, item) => sum + double.parse(item.amount.toString()));

      double foodExpense = expenseList
          .where((expense) => expense.category == i)
          .fold(0, (sum, item) => sum + double.parse(item.amount.toString()));

      // Calculate the percentage of "Food" expense
      double value = double.parse(
          ((foodExpense / totalExpense) * 100).toStringAsPrecision(2));
      ratio.add({i: value});
    });

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
        await databaseHelper.database,
        Expense(
            id: event.id,
            category: event.category,
            amount: event.amount,
            date: event.date,
            description: event.description));

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

  void _filterExpense(
      ExpenseFilterListEvent event, Emitter<ExpenseState> emit) async {
    // await ExpenseService.deleteItem(await databaseHelper.database, 17);
    if (event.week != null) {
      List<Map<String, dynamic>> res = await ExpenseService.getRecordsByWeek(
          await databaseHelper.database,
          week: event.week,
          year: event.year);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    } else if (event.month != null) {
      List<Map<String, dynamic>> res = await ExpenseService.getRecordsByMonth(
          await databaseHelper.database,
          month: event.month,
          year: event.year);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    } else {
      List<Map<String, dynamic>> res = await ExpenseService.getRecordsByYear(
          await databaseHelper.database,
          year: event.year);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    }
  }
}
