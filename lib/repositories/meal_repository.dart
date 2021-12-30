import 'package:macro/models/meal.dart';
import 'package:macro/utils/db/db_connector.dart';
import 'package:sembast/sembast.dart';

class MealRepository {
  final DbConnector _dbConnector;

  MealRepository._internal(this._dbConnector);

  factory MealRepository({DbConnector? dbConnector}) {
    return MealRepository._internal(
        dbConnector ?? DbConnector(),
    );
  }

  Future<List<Meal>> findAll() async {
    final list = await _dbConnector.meal.find(await _dbConnector.db);
    return list
        .map((record) => Meal.fromJson(record.value))
        .toList();
  }

  Future<void> add(Meal meal) async {
    await _dbConnector.meal.add(await _dbConnector.db, meal.toJson());
  }

  Future<void> save(int index, Meal meal) async {
    final key = index + 1;
    await _dbConnector.meal.record(key).put(await _dbConnector.db, meal.toJson());
  }
}
