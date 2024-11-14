import 'package:equatable/equatable.dart';

class Expense extends Equatable {
  final int? id;
  final String? category;
  final String? amount;
  final String? date;
  final String? description;

  const Expense({
    this.id,
    required this.category,
    required this.amount,
    required this.date,
    required this.description,
  });

  @override
  List<Object?> get props => [id, category, amount, date, description];

  factory Expense.fromJson(Map<String, Object?> json) => Expense(
        id: json["id"] as int,
        category: json["category"] as String,
        amount: json["amount"].toString(),
        date: json["date"] as String,
        description: json["description"] as String,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['category'] = category;
    data['amount'] = amount;
    data['date'] = date;
    data['description'] = description;

    return data;
  }
}
