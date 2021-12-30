import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/meal_amount.dart';

class MealAmountCard extends StatelessWidget {
  final MealAmount mealAmount;
  final GestureTapCallback? onTap;

  const MealAmountCard({Key? key, required this.mealAmount, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unity = mealAmount.meal.unity;

    final highlightColor = HSLColor.fromColor(Colors.yellow).withLightness(0.95).toColor();

    return Card(
      color: mealAmount.highlighted ? highlightColor : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: onTap,
            leading: Icon(Icons.fastfood),
            title: Text('${mealAmount.meal.name} - ${mealAmount.amount.toStringAsFixed(1)} $unity'),
            subtitle: Text('C: ${mealAmount.carb.toStringAsFixed(1)}g   G: ${mealAmount.fat.toStringAsFixed(1)}g   P: ${mealAmount.protein.toStringAsFixed(1)}g   \nkcal: ${mealAmount.kcal.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }

}