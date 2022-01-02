import 'package:macro/utils/types.dart';
import 'package:meta/meta.dart';

import 'meal.dart';

@immutable
class MealAmount {
  final Meal meal;
  final double amount;
  final String? color;

  const MealAmount(this.meal, this.amount, {this.color});

  double get carb => meal.carbPerUnit * amount;
  double get fat => meal.fatPerUnit * amount;
  double get protein => meal.proteinPerUnit * amount;

  double get kcal => carb * 4 + fat * 9 + protein * 4;

  MealAmount copyWith({Meal? meal, double? amount, String? color = undefinedString}) {
    return MealAmount(meal ?? this.meal, amount ?? this.amount,
      color: color == undefinedString ? this.color : color,
    );
  }

  factory MealAmount.fromJson(Map<String, dynamic> json) {
    return MealAmount(
      Meal.fromJson(json['meal']),
      json['amount'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
    'meal': meal.toJson(),
    'amount': amount,
    'color': color,
  };
}
