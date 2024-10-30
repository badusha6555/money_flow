import 'package:hive/hive.dart';
part 'advisor.g.dart';

@HiveType(typeId: 3)
class BudgetSetter {
  @HiveField(0)
  String? category;
  @HiveField(1)
  String? amount;
  BudgetSetter({
    this.category,
    this.amount,
  });
}
