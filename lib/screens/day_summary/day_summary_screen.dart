import 'package:flutter/material.dart';
import 'package:macro/models/day_meals.dart';
import 'package:macro/models/day_target.dart';
import 'package:macro/models/meal.dart';
import 'package:macro/models/meal_amount.dart';
import 'package:macro/repositories/day_meals_repository.dart';
import 'package:macro/screens/day_summary/day_target_screen.dart';
import 'package:macro/utils/extensions/collection.dart';
import 'package:macro/utils/extensions/color.dart';
import 'package:macro/utils/extensions/num.dart';
import 'package:macro/widgets/color_picker.dart';
import 'package:macro/widgets/day_macro_summary.dart';
import 'package:macro/widgets/meal_amount_card.dart';
import 'package:macro/widgets/week_macro_summary.dart';

import 'select_meal_screen.dart';

class DaySummaryScreen extends StatefulWidget {
  const DaySummaryScreen({Key? key}) : super(key: key);

  @override
  State<DaySummaryScreen> createState() => _DaySummaryScreenState();
}

class _DaySummaryScreenState extends State<DaySummaryScreen> {
  final dayMealsRepository = DayMealsRepository();

  final PageController _pageController = PageController();

  var _allDayMeals = <DayMeals>[];
  var _allDayMealsPosition = -1;

  var _undoStack = <_States>[];
  var _undoStackPosition = 0;

  @override
  void initState() {
    final now = DateTime.now();
    final today =
        "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    dayMealsRepository.findAll().then((allDayMeals) {
      setState(() {
        final todayDayMeals =
            allDayMeals.firstWhereOrNull((element) => element.date == today);
        if (todayDayMeals == null) {
          final previousDayMeals = allDayMeals.isNotEmpty ? allDayMeals.last : null;

          final dayMeals =
              DayMeals(today, meals: const [], resetAccumulator: false,
                  target: previousDayMeals?.target ?? const DayTarget(81, 2.5, 0.8, 2));
          dayMealsRepository.save(today, dayMeals);
          _allDayMeals = [...allDayMeals, dayMeals];
          _allDayMealsPosition = _allDayMeals.length - 1;
        } else {
          _allDayMeals = allDayMeals;
          _allDayMealsPosition = _allDayMeals.length - 1;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dayMeals =
        _allDayMealsPosition == -1 ? null : _allDayMeals[_allDayMealsPosition];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Macro"),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      enabled: _undoStackPosition > 0,
                      onTap: () {
                        _undoAction();
                      },
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.undo,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Desfazer"),
                          ),
                        ],
                      ),
                      value: 1,
                    ),
                    PopupMenuItem(
                      enabled: _undoStackPosition < _undoStack.length,
                      onTap: () {
                        _redoAction();
                      },
                      child: Row(
                        children: const <Widget>[
                          Icon(
                            Icons.redo,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Refazer"),
                          ),
                        ],
                      ),
                      value: 2,
                    )
                  ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            dayMeals == null ? null : _onAddButtonPressed(dayMeals),
        child: const Icon(Icons.add),
      ),
      body: dayMeals == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        DayMacroSummary(
                          dayMeals: dayMeals,
                          onBackPressed: _allDayMealsPosition == 0
                              ? null
                              : () {
                                  setState(() {
                                    _allDayMealsPosition--;
                                  });
                                },
                          onForwardPressed:
                              _allDayMealsPosition == _allDayMeals.length - 1
                                  ? null
                                  : () {
                                      setState(() {
                                        _allDayMealsPosition++;
                                      });
                                    },
                          onDatePressed: () {
                            final initialDate = DateTime.parse(dayMeals.date);
                            final firstDate = DateTime.parse('2021-01-01');

                            showDatePicker(
                              context: context,
                              lastDate: DateTime.now(),
                              initialDate: initialDate,
                              firstDate: firstDate,
                            );
                          },
                          onTargetTap: () async {
                            DayTarget? newDayTarget = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DayTargetScreen(dayTarget: dayMeals.target)),
                            );
                            if (newDayTarget == null) return;

                            setState(() {
                              final newDayMeals =
                              dayMeals.copyWith(target: newDayTarget);
                              _changeCurrentDayMeals(newDayMeals);
                            });
                          },
                        ),
                        WeekMacroSummary(
                          allDayMeals: _allDayMeals,
                          allDayMealsPosition: _allDayMealsPosition,
                          onResetAccumulatorPressed: () {
                            setState(() {
                              final newDayMeals =
                                dayMeals.copyWith(resetAccumulator: !dayMeals.resetAccumulator);
                              _changeCurrentDayMeals(newDayMeals);
                            });
                          },
                        )
                      ],
                    ),
                  ),
                  dayMeals.meals.isEmpty
                      ? TextButton(
                          onPressed: () => _onAddButtonPressed(dayMeals),
                          child: const Text("Adicionar uma refeição do dia..."),
                        )
                      : Theme(
                          data: ThemeData(canvasColor: Colors.transparent),
                          child: ReorderableListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: dayMeals.meals.length,
                            itemBuilder: (context, index) {
                              final mealAmount = dayMeals.meals[index];
                              return Dismissible(
                                key: Key(mealAmount.hashCode.toString()),
                                child: MealAmountCard(
                                  onTap: () => _onMealAmountCardTap(
                                      dayMeals, mealAmount),
                                  mealAmount: mealAmount,
                                ),
                                onDismissed: (_) => _onMealAmountCardDismissed(
                                    dayMeals, mealAmount),
                              );
                            },
                            onReorder: (int oldIndex, int newIndex) async {
                              final newMeals = [...dayMeals.meals];
                              final element = newMeals.removeAt(oldIndex);
                              newMeals.insert(
                                  newIndex - (newIndex > oldIndex ? 1 : 0),
                                  element);

                              setState(() {
                                final newDayMeals =
                                    dayMeals.copyWith(meals: [...newMeals]);
                                _changeCurrentDayMeals(newDayMeals);
                              });
                            },
                          ),
                        ),
                ],
              ),
            ),
    );
  }

  Future<void> _onAddButtonPressed(DayMeals dayMeals) async {
    final Meal? meal = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectMealScreen()),
    );

    if (meal == null) return;
    final defaultMealAmount = MealAmount(meal, meal.baseAmount);
    final mealAmount =
        await _showEditMealAmountDialog(defaultMealAmount) ?? defaultMealAmount;

    setState(() {
      final newDayMeals = dayMeals.copyWith(
        meals: [mealAmount, ...dayMeals.meals],
      );
      _changeCurrentDayMeals(newDayMeals);
    });
  }

  void _changeCurrentDayMeals(DayMeals newDayMeals) {
    _pushUndoState(newDayMeals);
    _allDayMeals[_allDayMealsPosition] = newDayMeals;
    dayMealsRepository.save(newDayMeals.date, newDayMeals);
  }

  void _pushUndoState(newDayMeals) {
    if (_undoStackPosition < _undoStack.length) {
      _undoStack = _undoStack.sublist(0, _undoStackPosition);
    }
    _undoStack.add(_States(_allDayMealsPosition,
        oldDayMeals: _allDayMeals[_allDayMealsPosition],
        newDayMeals: newDayMeals));
    _undoStackPosition++;
  }

  void _undoAction() {
    setState(() {
      final action = _undoStack[_undoStackPosition - 1];
      _allDayMealsPosition = action.position;
      _allDayMeals[action.position] = action.oldDayMeals;
      dayMealsRepository.save(action.oldDayMeals.date, action.oldDayMeals);
      _undoStackPosition--;
    });
  }

  void _redoAction() {
    setState(() {
      final action = _undoStack[_undoStackPosition];
      _allDayMealsPosition = action.position;
      _allDayMeals[action.position] = action.newDayMeals;
      dayMealsRepository.save(action.newDayMeals.date, action.newDayMeals);
      _undoStackPosition++;
    });
  }

  Future<void> _onMealAmountCardTap(
      DayMeals dayMeals, MealAmount mealAmount) async {
    final newMealAmount = await _showEditMealAmountDialog(mealAmount);
    if (newMealAmount == null) return;

    setState(() {
      final newDayMeals = dayMeals.copyWith(
          meals: dayMeals.meals
              .map((e) => e == mealAmount ? newMealAmount : e)
              .toList());

      _changeCurrentDayMeals(newDayMeals);
    });
  }

  Future<void> _onMealAmountCardDismissed(
      DayMeals dayMeals, MealAmount mealAmount) async {
    setState(() {
      final newDayMeals = dayMeals.copyWith(
          meals: dayMeals.meals.where((e) => e != mealAmount).toList());
      _changeCurrentDayMeals(newDayMeals);
    });
  }

  Future<MealAmount?> _showEditMealAmountDialog(MealAmount mealAmount) async {
    return await showDialog<MealAmount>(
        context: context,
        builder: (context) {
          var color = HexColor.fromHex(mealAmount.color);
          final controller = TextEditingController(
              text: mealAmount.amount.toStringAsFixedIfHasDecimal(1));
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
                  ColorPicker(
                      onSelectColor: (selectedColor) {
                        setState(() {
                          color = selectedColor;
                        });
                      },
                      availableColors: const <Color>[
                        Colors.yellow,
                        Colors.green,
                        Colors.red,
                        Colors.blue
                      ],
                      firstColor: color)
                ],
              ),
              title: Text(mealAmount.meal.name),
              actions: <Widget>[
                TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(mealAmount.copyWith(
                          amount: double.parse(controller.value.text),
                          color: color?.toHex()));
                    })
              ],
            );
          });
        });
  }
}

class _States {
  final int position;
  final DayMeals oldDayMeals;
  final DayMeals newDayMeals;

  _States(this.position,
      {required this.oldDayMeals, required this.newDayMeals});
}
