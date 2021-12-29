import 'package:meta/meta.dart';

@immutable
class DayTarget {
  final double weight;
  final double carbGramWeight;
  final double fatGramWeight;
  final double proteinGramWeight;

  const DayTarget(this.weight, this.carbGramWeight, this.fatGramWeight, this.proteinGramWeight);

  double get carb => weight * carbGramWeight;
  double get fat => weight * fatGramWeight;
  double get protein => weight * proteinGramWeight;
}
