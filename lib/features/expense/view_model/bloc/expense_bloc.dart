import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_app/features/expense/model/model.dart';

import '../../../../core/db/database_helper.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(const ExpenseState()) {
    // on<ExpenseEvent>((event, emit) {});
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    on<ExpenseListEvent>((event, emit) async {
      List<Map<String, dynamic>> res =
          await ExpenseService.getItems(await databaseHelper.database);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    });

    on<ExpenseAddEvent>((event, emit) async {
      await ExpenseService.insertItem(
          await databaseHelper.database, event.expense);

      List<Map<String, dynamic>> res =
          await ExpenseService.getItems(await databaseHelper.database);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    });

    on<ExpenseUpdateEvent>((event, emit) async {
      await ExpenseService.updateItem(
          await databaseHelper.database, event.expense);

      List<Map<String, dynamic>> res =
          await ExpenseService.getItems(await databaseHelper.database);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    });

    on<ExpenseDeleteEvent>((event, emit) async {
      await ExpenseService.deleteItem(await databaseHelper.database, event.id);
      List<Map<String, dynamic>> res =
          await ExpenseService.getItems(await databaseHelper.database);

      List<Expense> expenseList =
          res.map((item) => Expense.fromJson(item)).toList();

      emit(state.copyWith(expenseList: expenseList));
    });
  }
}
