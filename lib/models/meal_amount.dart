import 'package:meta/meta.dart';

import 'meal.dart';

@immutable
class MealAmount {
  final Meal meal;
  final double amount;
  final bool highlighted;

  const MealAmount(this.meal, this.amount, {this.highlighted = false});

  double get carb => meal.carbPerUnit * amount;
  double get fat => meal.fatPerUnit * amount;
  double get protein => meal.proteinPerUnit * amount;

  double get kcal => carb * 4 + fat * 9 + protein * 4;

  MealAmount copyWith({Meal? meal, double? amount, bool? highlighted}) {
    return MealAmount(meal ?? this.meal, amount ?? this.amount,
        highlighted: highlighted ?? this.highlighted,
    );
  }

  factory MealAmount.fromJson(Map<String, dynamic> json) {
    return MealAmount(
      Meal.fromJson(json['meal']),
      json['amount'],
      highlighted: json['highlighted'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'meal': meal.toJson(),
    'amount': amount,
    'highlighted': highlighted,
  };
}
