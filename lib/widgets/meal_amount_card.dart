import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/meal_amount.dart';
import 'package:macro/utils/extensions/color.dart';
import 'package:macro/utils/extensions/num.dart';

class MealAmountCard extends StatelessWidget {
  final MealAmount mealAmount;
  final GestureTapCallback? onTap;

  const MealAmountCard({Key? key, required this.mealAmount, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unity = mealAmount.meal.unity;

    Color? highlightColor;
    if (mealAmount.color != null) {
      highlightColor = HSLColor.fromColor(HexColor.fromHex(mealAmount.color)!).withLightness(0.95).toColor();
    }

    return Card(
      color: highlightColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: onTap,
            leading: Icon(Icons.fastfood),
            title: Text('${mealAmount.meal.name} - ${mealAmount.amount.toStringAsFixedIfHasDecimal(1)} $unity'),
            subtitle: Text('C: ${mealAmount.carb.toStringAsFixed(1)}g   G: ${mealAmount.fat.toStringAsFixed(1)}g   P: ${mealAmount.protein.toStringAsFixed(1)}g   \nkcal: ${mealAmount.kcal.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }

}