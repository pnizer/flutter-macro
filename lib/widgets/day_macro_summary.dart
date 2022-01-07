import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';
import 'package:macro/models/day_target.dart';

import 'macro_progress.dart';

class DayMacroSummary extends StatelessWidget {
  final DayMeals dayMeals;
  final VoidCallback? onDatePressed;
  final VoidCallback? onBackPressed;
  final VoidCallback? onForwardPressed;
  final VoidCallback? onTargetTap;

  const DayMacroSummary(
      {Key? key,
      required this.dayMeals,
      this.onDatePressed,
      this.onBackPressed,
      this.onForwardPressed,
      this.onTargetTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = dayMeals.date.isNotEmpty
        ? DateTime.parse(dayMeals.date)
        : DateTime.now();
    final formattedDate =
        "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}";

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black87,
              ),
              onPressed: onBackPressed,
              child: const Icon(Icons.arrow_back),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.black87,
                ),
                onPressed: onDatePressed,
                child: Row(children: <Widget>[
                  const Icon(Icons.today_outlined),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(formattedDate, textScaleFactor: 1.2),
                  ),
                ])),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black87,
              ),
              onPressed: onForwardPressed,
              child: const Icon(Icons.arrow_forward),
            ),
          ],
        ),
        InkWell(
          onTap: onTargetTap,
          child: Column(children: [
            MacroProgress(
              type: "C",
              target: dayMeals.target.carb,
              value: dayMeals.carbTotal,
            ),
            MacroProgress(
              type: "G",
              target: dayMeals.target.fat,
              value: dayMeals.fatTotal,
            ),
            MacroProgress(
              type: "P",
              target: dayMeals.target.protein,
              value: dayMeals.proteinTotal,
            ),
            Container(
              alignment: AlignmentDirectional.centerStart,
              padding: const EdgeInsets.fromLTRB(40, 5, 5, 5),
              child: Text('kcal: ${dayMeals.kcalTotal.toStringAsFixed(0)}'),
            ),
          ]),
        ),
      ],
    );
  }
}
