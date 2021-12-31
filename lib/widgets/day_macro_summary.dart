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
    final date = dayMeals.date.isNotEmpty ? DateTime.parse(dayMeals.date) : DateTime.now();
    final formattedDate = "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";

    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.today_outlined),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(formattedDate, textScaleFactor: 1.3),
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
        Container(
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
          child: Text('kcal: ${dayMeals.kcalTotal.toStringAsFixed(0)}'),
        )
      ],
    );
  }
}

