import 'package:meta/meta.dart';

@immutable
class Meal {
  final String name;
  final String unity;
  final double baseAmount;
  final double carb;
  final double fat;
  final double protein;

  const Meal(this.name, this.unity, this.baseAmount, this.carb, this.fat, this.protein);

  double get carbPerUnit => carb / baseAmount;
  double get fatPerUnit => fat / baseAmount;
  double get proteinPerUnit => protein / baseAmount;

  double get kcal => carb * 4 + fat * 9 + protein * 4;
}
