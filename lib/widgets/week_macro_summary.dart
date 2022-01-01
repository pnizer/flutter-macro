import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';
import 'package:macro/models/day_target.dart';

import 'macro_progress.dart';

class WeekMacroSummary extends StatelessWidget {
  final List<DayMeals> allDayMeals;
  final int allDayMealsPosition;
  final DayTarget dayTarget;

  const WeekMacroSummary({
    Key? key, required this.allDayMeals, required this.allDayMealsPosition, required this.dayTarget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var position = allDayMealsPosition;
    var daysCount = 0;
    var carbTotalSum = 0.0;
    var fatTotalSum = 0.0;
    var proteinTotalSum = 0.0;
    var carbTargetSum = 0.0;
    var fatTargetSum = 0.0;
    var proteinTargetSum = 0.0;
    while (position >= 0) {
      carbTotalSum += allDayMeals[position].carbTotal;
      fatTotalSum += allDayMeals[position].fatTotal;
      proteinTotalSum += allDayMeals[position].proteinTotal;
      carbTargetSum += dayTarget.carb;
      fatTargetSum += dayTarget.fat;
      proteinTargetSum += dayTarget.protein;
      daysCount++;
      if (allDayMeals[position].resetAccumulator) {
        break;
      }
      position--;
    }
    var avarageKcal = (carbTotalSum * 4 + fatTotalSum * 9 + proteinTotalSum * 4) / daysCount;

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Acumulado', textScaleFactor: 1.3),
                ),
              ],
            )),
        MacroProgress(
          type: "C",
          target: carbTargetSum,
          value: carbTotalSum,
        ),
        MacroProgress(
          type: "G",
          target: fatTargetSum,
          value: fatTotalSum,
        ),
        MacroProgress(
          type: "P",
          target: proteinTargetSum,
          value: proteinTotalSum,
        ),
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
          child: Text('kcal/dia: ${avarageKcal.toStringAsFixed(0)}'),
        ),
      ],
    );
  }
}
