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
        .map((record) => Meal.fromJson({...record.value, 'id': record.key}))
        .toList();
  }

  Future<Meal> add(Meal meal) async {
    final key = await _dbConnector.meal.add(await _dbConnector.db, meal.toJson());
    return meal.copyWith(id: key);
  }

  Future<void> save(Meal meal) async {
    assert(meal.id != null);
    await _dbConnector.meal.record(meal.id!).put(await _dbConnector.db, meal.toJson());
  }

  Future<void> delete(Meal meal) async {
    assert(meal.id != null);
    await _dbConnector.meal.record(meal.id!).delete(await _dbConnector.db);
  }
}
