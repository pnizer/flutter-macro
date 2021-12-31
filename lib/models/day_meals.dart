import 'package:meta/meta.dart';
import 'meal_amount.dart';

@immutable
class DayMeals {
  final String date;
  final List<MealAmount> meals;
  final bool resetAccumulator;

  const DayMeals(this.date, {required this.meals, this.resetAccumulator = false});

  double get carbTotal => meals.fold(0, (value, element) => value + element.carb);
  double get fatTotal => meals.fold(0, (value, element) => value + element.fat);
  double get proteinTotal => meals.fold(0, (value, element) => value + element.protein);

  double get kcalTotal => carbTotal * 4 + fatTotal * 9 + proteinTotal * 4;

  DayMeals copyWith({String? date, List<MealAmount>? meals, bool? resetAccumulator}) {
    return DayMeals(date ?? this.date,
      meals: meals ?? this.meals,
      resetAccumulator: resetAccumulator ?? this.resetAccumulator,
    );
  }

  factory DayMeals.fromJson(Map<String, dynamic> json) {
    return DayMeals(
      json['date'],
      meals: (json['meals'] as List<dynamic>).map((e) => MealAmount.fromJson(e)).toList(),
      resetAccumulator: json['resetAccumulator'],
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'meals': meals.map((e) => e.toJson()).toList(),
    'resetAccumulator': resetAccumulator,
  };
}
