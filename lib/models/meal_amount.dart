import 'package:meta/meta.dart';

import 'meal.dart';

@immutable
class MealAmount {
  final Meal meal;
  final double amount;

  const MealAmount(this.meal, this.amount);

  double get carb => meal.carbPerUnit * amount;
  double get fat => meal.fatPerUnit * amount;
  double get protein => meal.proteinPerUnit * amount;

  double get kcal => carb * 4 + fat * 9 + protein * 4;

  MealAmount copyWith({Meal? meal, double? amount}) {
    return MealAmount(meal ?? this.meal, amount ?? this.amount);
  }
}
