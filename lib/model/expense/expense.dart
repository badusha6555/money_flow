import 'package:hive/hive.dart';
part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense {
  @HiveField(0)
  bool? isExpense;
  @HiveField(1)
  String? category;
  @HiveField(2)
  int? amount;
  @HiveField(3)
  String? description;
  @HiveField(4)
  final DateTime? date;
  Expense({
    required this.isExpense,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
  });
}
