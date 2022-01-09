import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macro/models/day_target.dart';
import 'package:macro/utils/extensions/num.dart';

class DayTargetScreen extends StatefulWidget {
  final DayTarget dayTarget;

  const DayTargetScreen({required this.dayTarget, Key? key}) : super(key: key);

  @override
  State<DayTargetScreen> createState() => _DayTargetScreenState();
}

class _DayTargetScreenState extends State<DayTargetScreen> {
  late final _carbController = TextEditingController();
  late final _fatController = TextEditingController();
  late final _proteinController = TextEditingController();
  late final _weightController = TextEditingController();

  double _totalCarb = 0.0;
  double _totalFat = 0.0;
  double _totalProtein = 0.0;
  double _totalKcal = 0.0;

  @override
  void initState() {
    _carbController.text = widget.dayTarget.carbGramWeight.toStringAsFixedIfHasDecimal(1);
    _fatController.text = widget.dayTarget.fatGramWeight.toStringAsFixedIfHasDecimal(1);
    _proteinController.text = widget.dayTarget.proteinGramWeight.toStringAsFixedIfHasDecimal(1);
    _weightController.text = widget.dayTarget.weight.toStringAsFixedIfHasDecimal(1);
    _updateTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Objetivo diário'),
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                Navigator.pop(context, DayTarget(
                  double.parse(_weightController.value.text),
                  double.parse(_carbController.value.text),
                  double.parse(_fatController.value.text),
                  double.parse(_proteinController.value.text),
                ));
              },
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          TextField(
            controller: _carbController,
            decoration: const InputDecoration(
              labelText: 'Carboidrato (g/kg)'
            ),
            onChanged: (_) => _updateTotal(),
          ),
          TextField(
            controller: _fatController,
            decoration: const InputDecoration(
              labelText: 'Gordura (g/kg)'
            ),
            onChanged: (_) => _updateTotal(),
          ),
          TextField(
            controller: _proteinController,
            decoration: const InputDecoration(
              labelText: 'Proteína (g/kg)'
            ),
            onChanged: (_) => _updateTotal(),
          ),
          TextField(
            controller: _weightController,
            decoration: const InputDecoration(
                labelText: 'Peso (kg)'
            ),
            onChanged: (_) => _updateTotal(),
          ),

        const Padding(
          padding: EdgeInsets.only(top: 15, bottom: 5),
          child: Text("Total"),
        ),
        Align(
            alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Carboidrato: ${_totalCarb.toStringAsFixed(0)} g",
                style: const TextStyle(color: Colors.black54),
              ),
              Text(
                "Gordura: ${_totalFat.toStringAsFixed(0)} g",
                style: const TextStyle(color: Colors.black54),),
              Text(
                "Proteína: ${_totalProtein.toStringAsFixed(0)} g",
                style: const TextStyle(color: Colors.black54),),
              Text(
                "kcal: ${_totalKcal.toStringAsFixed(0)}",
                style: const TextStyle(color: Colors.black54),),
            ]
          ),
        ),
      ]),
    ));
  }

  void _updateTotal() {
    final weight = double.parse(_weightController.value.text);
    final carb = double.parse(_carbController.value.text);
    final fat = double.parse(_fatController.value.text);
    final protein = double.parse(_proteinController.value.text);

    setState(() {
      _totalCarb = carb * weight;
      _totalFat = fat * weight;
      _totalProtein = protein * weight;

      _totalKcal = _totalCarb * 4 + _totalFat * 9 +_totalProtein * 4;
    });
  }
}
