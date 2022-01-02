import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/meal.dart';
import 'package:macro/repositories/meal_repository.dart';
import 'package:macro/widgets/meal_card.dart';

class SelectMealScreen extends StatefulWidget {
  const SelectMealScreen({Key? key}) : super(key: key);

  @override
  State<SelectMealScreen> createState() => _SelectMealScreenState();
}

class _SelectMealScreenState extends State<SelectMealScreen> {
  late final _mealRepository = MealRepository();

  var _filter = '';
  var _meals = [];

  @override
  void initState() {
    _mealRepository.findAll().then((meals) => setState(() {
          _meals = meals;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final filteredMeals = _meals
        .where(
            (meal) => meal.name.toLowerCase().contains(_filter.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar refeição'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createNewMeal,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (text) {
              setState(() {
                _filter = text;
              });
            },
            autofocus: true,
            decoration: const InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: "Filtro",
              suffixIcon: Icon(Icons.filter_alt),
            ),
          ),
          filteredMeals.isEmpty
              ? TextButton(
                  onPressed: _createNewMeal,
                  child: const Text("Criar uma nova refeição..."),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: filteredMeals.length,
                    itemBuilder: (context, index) {
                      final meal = filteredMeals[index];

                      return Dismissible(
                          key: Key(meal.id.toString()),
                          confirmDismiss: (_) async {
                            return await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirmação"),
                                    content: Text(
                                        "Gostaria mesmo de apagar a refeição '${meal.name}'?"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(true),
                                          child: const Text("APAGAR")),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: const Text("CANCELAR"),
                                      ),
                                    ],
                                  );
                                });
                          },
                          onDismissed: (_) async {
                            await _mealRepository.delete(meal);
                            final meals = await _mealRepository.findAll();
                            setState(() {
                              _meals = meals;
                            });
                          },
                          child: MealCard(
                            onTap: () {
                              Navigator.pop(context, meal);
                            },
                            meal: meal,
                            onLongPress: () async {
                              final modifiedMeal =
                                  await _showEditMealAmountDialog(meal);

                              if (modifiedMeal == null) return;
                              await _mealRepository.save(modifiedMeal);
                              final meals = await _mealRepository.findAll();
                              setState(() {
                                _meals = meals;
                              });
                            },
                          ));
                    },
                  ),
                )
        ],
      ),
    );
  }

  Future<void> _createNewMeal() async {
    final meal =
        await _showEditMealAmountDialog(Meal(_filter, 0, 0, 0, 100, 'g'));
    if (meal == null) return;
    final savedMeal = await _mealRepository.add(meal);
    setState(() {
      _meals = [..._meals, savedMeal];
    });
  }

  Future<Meal?> _showEditMealAmountDialog(Meal meal) async {
    return await showDialog<Meal>(
        context: context,
        builder: (context) {
          final nameController = TextEditingController(text: meal.name);
          final carbController =
              TextEditingController(text: meal.carb.toString());
          final fatController =
              TextEditingController(text: meal.fat.toString());
          final proteinController =
              TextEditingController(text: meal.protein.toString());
          final baseAmountController =
              TextEditingController(text: meal.baseAmount.toString());
          final unityController = TextEditingController(text: meal.unity);

          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(
                      label: Text("Nome"),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: carbController,
                              decoration: const InputDecoration(
                                label: Text("C"),
                              ),
                            )),
                        SizedBox(
                            width: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: fatController,
                              decoration: const InputDecoration(
                                label: Text("G"),
                              ),
                            )),
                        SizedBox(
                            width: 50,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: proteinController,
                              decoration: const InputDecoration(
                                label: Text("P"),
                              ),
                            )),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: baseAmountController,
                            decoration: const InputDecoration(
                              label: Text("Quantidade base"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: TextField(
                            controller: unityController,
                            decoration: const InputDecoration(
                              label: Text("Unidade"),
                            ),
                          ),
                        ),
                      ]),
                ],
              ),
              title: Text("Refeição"),
              actions: <Widget>[
                TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      final newMeal = meal.copyWith(
                        name: nameController.value.text,
                        carb: double.parse(carbController.value.text),
                        fat: double.parse(fatController.value.text),
                        protein: double.parse(proteinController.value.text),
                        baseAmount:
                            double.parse(baseAmountController.value.text),
                        unity: unityController.value.text,
                      );
                      Navigator.of(context).pop(newMeal);
                    })
              ],
            );
          });
        });
  }
}
