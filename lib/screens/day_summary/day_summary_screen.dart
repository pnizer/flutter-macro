import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';
import 'package:macro/models/day_target.dart';
import 'package:macro/models/meal.dart';
import 'package:macro/models/meal_amount.dart';
import 'package:macro/repositories/day_meals_repository.dart';
import 'package:macro/widgets/day_macro_summary.dart';
import 'package:macro/widgets/meal_amount_card.dart';
import 'package:macro/widgets/week_macro_summary.dart';

import 'select_meal_screen.dart';

class DaySummaryScreen extends StatefulWidget {
  DaySummaryScreen({Key? key}) : super(key: key);

  @override
  State<DaySummaryScreen> createState() => _DaySummaryScreenState();
}

class _DaySummaryScreenState extends State<DaySummaryScreen> {
  final dayMealsRepository = DayMealsRepository();
  final target = const DayTarget(81, 2.5, 0.8, 2);

  final PageController _pageController = PageController();

  var _dayMeals = const DayMeals('', meals: [], resetAccumulator: false);

  @override
  void initState() {
    final now = DateTime.now();
    final today =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    dayMealsRepository.findById(today).then((dayMeals) async {
      if (dayMeals != null) {
        setState(() {
          _dayMeals = dayMeals;
        });
      } else {
        setState(() {
          _dayMeals = DayMeals(today, meals: const [], resetAccumulator: false);
          dayMealsRepository.save(today, _dayMeals);
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Macro"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddButtonPressed,
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
                      onTap: () => _onMealAmountCardTap(mealAmount),
                      mealAmount: mealAmount,
                    ),
                    onDismissed: (_) => _onMealAmountCardDismissed(mealAmount),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Future<void> _onAddButtonPressed() async {
    final Meal? meal = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectMealScreen()),
    );

    if (meal == null) return;
    final defaultMealAmount = MealAmount(meal, meal.baseAmount);
    final mealAmount =
        await _showEditMealAmountDialog(defaultMealAmount) ?? defaultMealAmount;

    setState(() {
      _dayMeals = _dayMeals.copyWith(
        meals: [mealAmount, ..._dayMeals.meals],
      );
      dayMealsRepository.save(_dayMeals.date, _dayMeals);
    });
  }

  Future<void> _onMealAmountCardTap(MealAmount mealAmount) async {
    final newMealAmount = await _showEditMealAmountDialog(mealAmount);
    if (newMealAmount == null) return;

    setState(() {
      _dayMeals = _dayMeals.copyWith(
          meals: _dayMeals.meals
              .map((e) => e == mealAmount ? newMealAmount : e)
              .toList());
      dayMealsRepository.save(_dayMeals.date, _dayMeals);
    });
  }

  Future<void> _onMealAmountCardDismissed(MealAmount mealAmount) async {
    setState(() {
      _dayMeals = _dayMeals.copyWith(
          meals: _dayMeals.meals
              .where((e) => e != mealAmount)
              .toList());
      dayMealsRepository.save(_dayMeals.date, _dayMeals);
    });
  }

  Future<MealAmount?> _showEditMealAmountDialog(MealAmount mealAmount) async {
    return await showDialog<MealAmount>(
        context: context,
        builder: (context) {
          var highlighted = mealAmount.highlighted;
          final controller =
              TextEditingController(text: mealAmount.amount.toStringAsFixed(1));
          controller.selection = TextSelection(
              baseOffset: 0, extentOffset: controller.text.length);

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        autofocus: true,
                        controller: controller,
                        keyboardType: TextInputType.number,
                      )),
                      Text(mealAmount.meal.unity),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Marcar'),
                      Checkbox(
                        value: highlighted,
                        onChanged: (_) {
                          setState(() {
                            highlighted = !highlighted;
                          });
                        },
                      ),
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
                          amount: double.parse(controller.value.text),
                          highlighted: highlighted));
                    })
              ],
            );
          });
        });
  }
}
