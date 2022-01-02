import 'package:meta/meta.dart';

@immutable
class Meal {
  final int? id;
  final String name;
  final double carb;
  final double fat;
  final double protein;
  final double baseAmount;
  final String unity;

  const Meal(this.name, this.carb, this.fat, this.protein, this.baseAmount, this.unity, {this.id});

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
        id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'carb': carb,
    'fat': fat,
    'protein': protein,
    'baseAmount': baseAmount,
    'unity': unity,
  };

  Meal copyWith({int? id, String? name, double? carb, double? fat,
    double? protein, double? baseAmount, String? unity}) {
    return Meal(
      name ?? this.name,
      carb ?? this.carb,
      fat ?? this.fat,
      protein ?? this.protein,
      baseAmount ?? this.baseAmount,
      unity ?? this.unity,
      id: id ?? this.id,
    );
  }
}
