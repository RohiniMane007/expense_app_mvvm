part of 'expense_bloc.dart';

/*sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}*/

class ExpenseState extends Equatable {
  final List<Expense> expenseList;
  const ExpenseState({this.expenseList = const []});

  ExpenseState copyWith({List<Expense>? expenseList}) {
    return ExpenseState(expenseList: expenseList ?? this.expenseList);
  }

  @override
  List<Object?> get props => [expenseList];
}
