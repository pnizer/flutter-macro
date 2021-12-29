import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';
import 'package:macro/models/day_target.dart';
import 'package:macro/models/meal.dart';
import 'package:macro/models/meal_amount.dart';
import 'package:macro/widgets/macro_progress.dart';
import 'package:macro/widgets/meal_amount_card.dart';

import 'select_meal_screen.dart';

class DaySummaryScreen extends StatefulWidget {
  DaySummaryScreen({Key? key}) : super(key: key);

  @override
  State<DaySummaryScreen> createState() => _DaySummaryScreenState();
}

class _DaySummaryScreenState extends State<DaySummaryScreen> {
  final target = DayTarget(81, 2.5, 0.8, 2);

  final PageController _pageController = PageController();

  var _dayMeals = DayMeals("29/12/2021",
      meals: [],
      resetAccumulator: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Macro"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final Meal? meal = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SelectMealScreen()),
          );

          if (meal == null) return;
          final defaultMealAmount = MealAmount(meal, meal.baseAmount);
          final mealAmount = await showEditMealAmountDialog(defaultMealAmount) ?? defaultMealAmount;

          setState(() {
            _dayMeals = _dayMeals.copyWith(
              meals: [mealAmount, ..._dayMeals.meals],
            );
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView(
                controller: _pageController,
                children: <Widget>[
                  DayMacroSummary(
                    dayMeals: _dayMeals,
                    target: target,
                  ),
                  WeekMacroSummary()
                ],
              ),
            ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                itemCount: _dayMeals.meals.length,
                itemBuilder: (context, index) {
                  final mealAmount = _dayMeals.meals[index];
                  return Dismissible(
                    key: Key(mealAmount.hashCode.toString()),
                    child: MealAmountCard(
                      onTap: () async {
                        final newMealAmount = await showEditMealAmountDialog(mealAmount);
                        if (newMealAmount == null) return;

                        setState(() {
                          _dayMeals = _dayMeals.copyWith(
                              meals: _dayMeals.meals.map((e) => e == mealAmount ? newMealAmount : e).toList()
                          );
                        });
                      },
                      mealAmount: mealAmount,
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        _dayMeals = _dayMeals.copyWith(
                          meals: _dayMeals.meals.where((e) => e != mealAmount).toList()
                        );
                      });
                    },
                  );
                }
              ),
          ],
        ),
      ),
    );
  }

  Future<MealAmount?> showEditMealAmountDialog(MealAmount mealAmount) async {
    return await showDialog<MealAmount>(
        context: context,
        builder: (context) {
          final controller = TextEditingController(text: mealAmount.amount.toStringAsFixed(0));
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: TextField(
                      autofocus: true,
                      controller: controller,
                    )),
                    Text(mealAmount.meal.unity),
                  ],
                )
              ],
            ),
            title: Text(mealAmount.meal.name),
            actions: <Widget>[
              TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(mealAmount.copyWith(
                      amount: double.parse(controller.value.text)
                    ));
                  }
              )
            ],
          );
        }
    );
  }

}

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

class WeekMacroSummary extends StatelessWidget {
  const WeekMacroSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text('Acumulado', textScaleFactor: 1.3),
                ),
              ],
            )),
        MacroProgress(
          type: "C",
          target: 202.5,
          value: 250.4,
        ),
        MacroProgress(
          type: "G",
          target: 64.8,
          value: 34.2,
        ),
        MacroProgress(
          type: "P",
          target: 162,
          value: 30,
        ),
      ],
    );
  }
}
