
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/meal.dart';
import 'package:macro/widgets/meal_card.dart';

class SelectMealScreen extends StatefulWidget {
  const SelectMealScreen({Key? key}) : super(key: key);

  @override
  State<SelectMealScreen> createState() => _SelectMealScreenState();
}

class _SelectMealScreenState extends State<SelectMealScreen> {
  var _filter = '';

  final _meals = <Meal>[
    Meal('Pão', 'uni', 1, 23, 0, 3),
    Meal('Presunto', 'g', 20, 0, 0.5, 3.35),
    Meal('Queijo', 'g', 20, 0.4, 4.8, 4.8),
    Meal('Mantega', 'g', 10, 0, 8.6, 0),
    Meal('Arroz', 'g', 50, 14, 0.1, 1.2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar refeição'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (text) {
              setState(() {
                _filter = text;
              });
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              hintText: "Filtro",
              suffixIcon: Icon(Icons.filter_alt),
            ),
          ),
          Expanded(child: SingleChildScrollView(
            child: Column(
              children: [
                ..._meals
                  .where((meal) => meal.name.toLowerCase().contains(_filter.toLowerCase()))
                  .map((meal) => MealCard(
                    meal: meal,
                    onTap: () {
                      Navigator.pop(context, meal);
                    },
                ))
              ],
            ),
          ))
        ],
      ),
    );
  }
}
