import 'package:macro/models/day_meals.dart';
import 'package:macro/utils/db/db_connector.dart';
import 'package:sembast/sembast.dart';

class DayMealsRepository {
  final DbConnector _dbConnector;

  DayMealsRepository._internal(this._dbConnector);

  factory DayMealsRepository({DbConnector? dbConnector}) {
    return DayMealsRepository._internal(
        dbConnector ?? DbConnector(),
    );
  }

  Future<List<DayMeals>> findAll() async {
    final list = await _dbConnector.dayMeals.find(await _dbConnector.db);
    return list
        .map((record) => DayMeals.fromJson(record.value))
        .toList();
  }

  Future<DayMeals?> findById(String id) async {
    final json = await _dbConnector.dayMeals.record(id).get(await _dbConnector.db);
    return json != null ? DayMeals.fromJson(json) : null;
  }

  Future<void> save(String id, DayMeals dayMeals) async {
    await _dbConnector.dayMeals.record(id).put(await _dbConnector.db, dayMeals.toJson());
  }
}
