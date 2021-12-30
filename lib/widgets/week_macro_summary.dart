import 'package:flutter/material.dart';

import 'macro_progress.dart';

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
