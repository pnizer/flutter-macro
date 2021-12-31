import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MacroProgress extends StatelessWidget {
  final double value;
  final double target;
  final String type;

  const MacroProgress({
    Key? key,
    required this.type,
    required this.target,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ratio = value / target;
    
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 20,
            child: Center(child: Text(type)),
          ),
        ),
        Expanded(
            child: LinearProgressIndicator(
              color: ratio > 1 ? Colors.red : Theme.of(context).primaryColorDark,
              backgroundColor: ratio > 1 ? Theme.of(context).primaryColorDark : null,
              value: ratio > 1 ? ratio - 1 : ratio,
            )
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 55,
            child: Text("${(target - value).toStringAsFixed(1)}g"),
          ),
        ),
      ],
    );
  }

}