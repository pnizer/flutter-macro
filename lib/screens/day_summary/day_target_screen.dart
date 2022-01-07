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

  @override
  void initState() {
    _carbController.text = widget.dayTarget.carbGramWeight.toStringAsFixedIfHasDecimal(1);
    _fatController.text = widget.dayTarget.fatGramWeight.toStringAsFixedIfHasDecimal(1);
    _proteinController.text = widget.dayTarget.proteinGramWeight.toStringAsFixedIfHasDecimal(1);
    _weightController.text = widget.dayTarget.weight.toStringAsFixedIfHasDecimal(1);
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          TextField(
            controller: _carbController,
            decoration: InputDecoration(
              labelText: 'Carboidrato (g/kg)'
            ),
          ),
          TextField(
            controller: _fatController,
            decoration: InputDecoration(
              labelText: 'Gordura (g/kg)'
            ),
          ),
          TextField(
            controller: _proteinController,
            decoration: InputDecoration(
              labelText: 'Proteína (g/kg)'
            ),
          ),
          TextField(
            controller: _weightController,
            decoration: InputDecoration(
                labelText: 'Peso (kg)'
            ),
          ),
        ],
      ),
    ));
  }
}
