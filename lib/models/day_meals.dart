import 'package:meta/meta.dart';
import 'day_target.dart';
import 'meal_amount.dart';

@immutable
class DayMeals {
  final String date;
  final List<MealAmount> meals;
  final bool resetAccumulator;
  final DayTarget target;

  const DayMeals(this.date, {required this.meals, this.resetAccumulator = false, required this.target});

  double get carbTotal => meals.fold(0, (value, element) => value + element.carb);
  double get fatTotal => meals.fold(0, (value, element) => value + element.fat);
  double get proteinTotal => meals.fold(0, (value, element) => value + element.protein);

  double get kcalTotal => carbTotal * 4 + fatTotal * 9 + proteinTotal * 4;

  DayMeals copyWith({String? date, List<MealAmount>? meals, bool? resetAccumulator, DayTarget? target}) {
    return DayMeals(date ?? this.date,
      meals: meals ?? this.meals,
      resetAccumulator: resetAccumulator ?? this.resetAccumulator,
      target: target ?? this.target,
    );
  }

  factory DayMeals.fromJson(Map<String, dynamic> json) {
    return DayMeals(
      json['date'],
      meals: (json['meals'] as List<dynamic>).map((e) => MealAmount.fromJson(e)).toList(),
      resetAccumulator: json['resetAccumulator'],
      target: DayTarget.fromJson(json['target']),
    );
  }

  Map<String, dynamic> toJson() => {
    'date': date,
    'meals': meals.map((e) => e.toJson()).toList(),
    'resetAccumulator': resetAccumulator,
    'target': target.toJson(),
  };
}
