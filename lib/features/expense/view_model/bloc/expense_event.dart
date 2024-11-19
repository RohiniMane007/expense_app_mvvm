part of 'expense_bloc.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

class ExpenseListEvent extends ExpenseEvent {}

class ExpenseAddEvent extends ExpenseEvent {
  final Expense expense;
  const ExpenseAddEvent({
    required this.expense,
  });
}

class ExpenseUpdateEvent extends ExpenseEvent {
  final Expense expense;
  const ExpenseUpdateEvent({required this.expense});
}

class ExpenseDeleteEvent extends ExpenseEvent {
  final int id;
  const ExpenseDeleteEvent({required this.id});
}
