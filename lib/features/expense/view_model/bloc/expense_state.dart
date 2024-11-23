part of 'expense_bloc.dart';

/*sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}*/

class ExpenseState extends Equatable {
  final List<Expense> expenseList;
  final List<Map<String, double>> ratio;
  const ExpenseState({this.expenseList = const [], this.ratio = const []});

  ExpenseState copyWith(
      {List<Expense>? expenseList, List<Map<String, double>>? ratio}) {
    return ExpenseState(
        expenseList: expenseList ?? this.expenseList,
        ratio: ratio ?? this.ratio);
  }

  @override
  List<Object?> get props => [expenseList];
}
