import 'package:hive/hive.dart';
part 'income.g.dart';

@HiveType(typeId: 1)
class Income {
  @HiveField(0)
  bool? isIncome;
  @HiveField(1)
  String? category;
  @HiveField(2)
  int? amount;
  @HiveField(3)
  String? description;
  @HiveField(4)
  final DateTime? date;
  Income({
    required this.isIncome,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
  });
}
