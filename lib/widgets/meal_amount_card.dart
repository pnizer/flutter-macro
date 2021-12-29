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

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: onTap,
            leading: Icon(Icons.fastfood),
            title: Text('${mealAmount.meal.name} - ${mealAmount.amount < 1 ? mealAmount.amount : mealAmount.amount.toStringAsFixed(0)} $unity'),
            subtitle: Text('C: ${mealAmount.carb.toStringAsFixed(1)}g   G: ${mealAmount.fat.toStringAsFixed(1)}g   P: ${mealAmount.protein.toStringAsFixed(1)}g   \nKCal: ${mealAmount.kcal.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }

}