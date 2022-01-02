import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/meal.dart';
import 'package:macro/utils/extensions/num.dart';

class MealCard extends StatelessWidget {
  final Meal meal;
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;

  const MealCard({Key? key, required this.meal, this.onTap, this.onLongPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final unity = meal.unity;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            onTap: onTap,
            onLongPress: onLongPress,
            leading: Icon(Icons.fastfood),
            title: Text('${meal.name} - ${meal.baseAmount.toStringAsFixedIfHasDecimal(1)} $unity'),
            subtitle: Text('C: ${meal.carb.toStringAsFixed(1)}g   G: ${meal.fat.toStringAsFixed(1)}g   P: ${meal.protein.toStringAsFixed(1)}g   \nkcal: ${meal.kcal.toStringAsFixed(0)}'),
          ),
        ],
      ),
    );
  }
}
