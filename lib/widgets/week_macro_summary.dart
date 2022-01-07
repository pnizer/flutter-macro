import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';

import 'macro_progress.dart';

class WeekMacroSummary extends StatelessWidget {
  final List<DayMeals> allDayMeals;
  final int allDayMealsPosition;
  final void Function() onResetAccumulatorPressed;

  const WeekMacroSummary(
      {Key? key,
      required this.allDayMeals,
      required this.allDayMealsPosition,
      required this.onResetAccumulatorPressed})
      : super(key: key);

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
      carbTargetSum += allDayMeals[position].target.carb;
      fatTargetSum += allDayMeals[position].target.fat;
      proteinTargetSum += allDayMeals[position].target.protein;
      daysCount++;
      if (allDayMeals[position].resetAccumulator) {
        break;
      }
      position--;
    }
    var avarageKcal =
        (carbTotalSum * 4 + fatTotalSum * 9 + proteinTotalSum * 4) / daysCount;

    final resetAccumulator = allDayMeals[allDayMealsPosition].resetAccumulator;

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text('Acumulado – $daysCount dia${daysCount > 1 ? 's' : ''}', textScaleFactor: 1.3),
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
            padding: const EdgeInsets.fromLTRB(40, 5, 75, 5),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('kcal/dia: ${avarageKcal.toStringAsFixed(0)}'),
                  InkWell(
                      onTap: onResetAccumulatorPressed,
                      child: Row(children: [
                        const Text('Reiniciar: '),
                        Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 1, color: Colors.black45),
                            ),
                            child: Icon(
                              Icons.check,
                              size: 15,
                              color:
                                  !resetAccumulator ? Colors.transparent : null,
                            ))
                      ]))
                ])),
      ],
    );
  }
}
