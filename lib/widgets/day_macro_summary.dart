import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';
import 'package:macro/models/day_target.dart';

import 'macro_progress.dart';

class DayMacroSummary extends StatelessWidget {
  final DayMeals dayMeals;
  final DayTarget target;

  const DayMacroSummary(
      {Key? key, required this.dayMeals, required this.target})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.today_outlined),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(dayMeals.date, textScaleFactor: 1.3),
                ),
              ],
            )),
        MacroProgress(
          type: "C",
          target: target.carb,
          value: dayMeals.carbTotal,
        ),
        MacroProgress(
          type: "G",
          target: target.fat,
          value: dayMeals.fatTotal,
        ),
        MacroProgress(
          type: "P",
          target: target.protein,
          value: dayMeals.proteinTotal,
        ),
      ],
    );
  }
}

