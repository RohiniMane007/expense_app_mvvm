part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class ExpenseListEvent extends ExpenseEvent {}

class ExpenseAddEvent extends ExpenseEvent {
  final String category, amount, description, date;
  // final Expense expense;
  const ExpenseAddEvent(
      {required this.category,
      required this.amount,
      required this.description,
      required this.date
      // required this.expense,
      });
}

class ExpenseUpdateEvent extends ExpenseEvent {
  final String category, amount, description, date;
  final int id;
  const ExpenseUpdateEvent(
      {required this.id,
      required this.category,
      required this.amount,
      required this.description,
      required this.date
      // required this.expense,
      });
}

class ExpenseDeleteEvent extends ExpenseEvent {
  final int id;
  const ExpenseDeleteEvent({required this.id});
}

class ExpenseFilterListEvent extends ExpenseEvent {
  final int? week, month, year;
  const ExpenseFilterListEvent({this.week, this.month, this.year});
}
