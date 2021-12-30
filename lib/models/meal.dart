import 'package:meta/meta.dart';

@immutable
class Meal {
  final String name;
  final double carb;
  final double fat;
  final double protein;
  final double baseAmount;
  final String unity;

  const Meal(this.name, this.carb, this.fat, this.protein, this.baseAmount, this.unity);

  double get carbPerUnit => carb / baseAmount;
  double get fatPerUnit => fat / baseAmount;
  double get proteinPerUnit => protein / baseAmount;

  double get kcal => carb * 4 + fat * 9 + protein * 4;

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
        json['name'],
        json['carb'],
        json['fat'],
        json['protein'],
        json['baseAmount'],
        json['unity'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'carb': carb,
    'fat': fat,
    'protein': protein,
    'baseAmount': baseAmount,
    'unity': unity,
  };
}
