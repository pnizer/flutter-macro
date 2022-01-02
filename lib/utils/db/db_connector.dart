import 'package:macro/models/meal.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class DbConnector {
  static const version = 3;

  // lazy loaded singleton instance
  static late final _instance = DbConnector._internal();

  late final Future<Database> db = _openDatabase();
  final dayMeals = stringMapStoreFactory.store('day_meals');
  final meal = intMapStoreFactory.store('meal');

  // private constructor
  DbConnector._internal();

  // public factory
  factory DbConnector() => _instance;

  Future<Database> _openDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final dbPath = join(dir.path, 'macro.db');
    return databaseFactoryIo.openDatabase(dbPath,
        version: version,
        onVersionChanged: _dbUpdate,
    );
  }

  Future<void> _dbUpdate(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 0) {
      await meal.add(db, const Meal('Pão Francês', 23, 0, 3, 1, 'uni').toJson());
      await meal.add(db, const Meal('Presunto', 0, 0.5, 3.35, 20, 'g').toJson());
      await meal.add(db, const Meal('Queijo', 0.4, 4.8, 4.8, 20, 'g').toJson());
      await meal.add(db, const Meal('Mantega', 0, 8.6, 0, 10, 'g').toJson());
      await meal.add(db, const Meal('Arroz', 14, 0.1, 1.2, 50, 'g').toJson());
      await meal.add(db, const Meal('Feijão', 19.6, 0.7, 6.3, 140, 'g').toJson());
      await meal.add(db, const Meal('Ovo frito', 0.6, 9.3, 7.8, 1, 'uni').toJson());
      await meal.add(db, const Meal('Farofa', 12, 1.37, 0.3, 1, 'colher').toJson());
      await meal.add(db, const Meal('Whey Growth creme', 4, 1.6, 23, 1, 'dose').toJson());
      await meal.add(db, const Meal('Pão de hamburguer', 28, 1.55, 3.75, 50, 'g').toJson());
      await meal.add(db, const Meal('Hamburguer', 0.34, 10.3, 8.9, 1, 'uni').toJson());
      await meal.add(db, const Meal('Pão fatiado integral', 20, 1.7, 5.7, 2, 'fatia').toJson());
      await meal.add(db, const Meal('Pizza', 26.56, 10.1, 12.37, 1, 'fatia').toJson());
      await meal.add(db, const Meal('Peito de frango (cru)', 0, 4, 20, 100, 'g').toJson());
      await meal.add(db, const Meal('Alcatra (grelhada)', 0, 11.6, 31.9, 100, 'g').toJson());
      await meal.add(db, const Meal('Bolo', 42, 14.5, 3.18, 1, 'fatia').toJson());
      await meal.add(db, const Meal('Banana', 10.3, 0.12, 0.5, 1, 'uni').toJson());
      await meal.add(db, const Meal('Ovo', 0.6, 5, 6, 1, 'uni').toJson());
      await meal.add(db, const Meal('Batata salsa', 18.9, 0.2, 0.9, 100, 'g').toJson());
      await meal.add(db, const Meal('Azeite', 0, 3.7, 0, 1, 'colher chá').toJson());
      await meal.add(db, const Meal('Linguiça', 0, 13, 14, 60, 'g').toJson());
      await meal.add(db, const Meal('Bigmac', 42, 26, 26, 1, 'uni').toJson());
      await meal.add(db, const Meal('Batata Mc Med', 35, 15, 5, 1, 'uni').toJson());
      await meal.add(db, const Meal('Chicabom', 18, 2.7, 1.8, 1, 'uni').toJson());
      await meal.add(db, const Meal('Heineken ', 6.4, 0, 0.8, 200, 'ml').toJson());
      await meal.add(db, const Meal('Palmito conserva', 1.9, 0, 1.4, 50, 'g').toJson());
      await meal.add(db, const Meal('Mignon assado', 0, 9, 33, 100, 'g').toJson());
      await meal.add(db, const Meal('Maionese batata ', 11, 10.5, 2, 80, 'g').toJson());
      await meal.add(db, const Meal('Schwepps Ginger', 10, 0, 0, 1, 'uni').toJson());
      await meal.add(db, const Meal('Penne 4 queijos ', 47, 7, 14, 200, '1').toJson());
      await meal.add(db, const Meal('Leite', 9.1, 6.5, 6.3, 200, 'ml').toJson());
      await meal.add(db, const Meal('Iogurte grego', 13, 6, 4.5, 100, 'g').toJson());
      await meal.add(db, const Meal('Amendoim', 4.7, 13.5, 5.6, 25, 'g').toJson());
      await meal.add(db, const Meal('Castanha de caju', 8.2, 11.6, 3.9, 25, 'g').toJson());
      await meal.add(db, const Meal('Carne moída com molho', 4.16, 11.6, 13, 150, 'g').toJson());
      await meal.add(db, const Meal('Bis', 19, 7.9, 1.7, 4, 'uni').toJson());
      await meal.add(db, const Meal('Strognoff de carne', 6, 10, 10, 100, 'g').toJson());
      await meal.add(db, const Meal('Batata palha', 9.3, 12, 1.4, 25, 'g').toJson());
      await meal.add(db, const Meal('Macarrão', 15.4, 0.5, 2.9, 50, 'g').toJson());
      await meal.add(db, const Meal('Nescau', 17, 0.6, 0.7, 20, 'g').toJson());
      await meal.add(db, const Meal('Beterraba', 1.5, 0.02, 0.2, 20, 'g').toJson());
      await meal.add(db, const Meal('Cenoura', 1.3, 0.04, 0.16, 20, 'g').toJson());
      await meal.add(db, const Meal('Coca-Cola ', 21, 0, 0, 200, 'ml').toJson());
      await meal.add(db, const Meal('Cebola refogada', 10.2, 3.6, 1.36, 100, 'g').toJson());
      await meal.add(db, const Meal('Barreado', 2, 11.7, 17.6, 100, 'g').toJson());
      await meal.add(db, const Meal('Farinha de mandioca', 13.8, 0, 0.27, 1, 'colher').toJson());
      await meal.add(db, const Meal('Polenta frita', 16.2, 0.35, 1.7, 50, 'g').toJson());
      await meal.add(db, const Meal('Óleo de soja', 0, 12, 0, 1, 'colher').toJson());
      await meal.add(db, const Meal('Bife à milanesa', 10.9, 25.56, 17.5, 100, 'g').toJson());
      await meal.add(db, const Meal('Vinagrete', 1.44, 2.9, 0.1, 1, 'colher').toJson());
      await meal.add(db, const Meal('Maionese Hemmer', 0.7, 4.3, 0, 12, 'g').toJson());
      await meal.add(db, const Meal('Leite desnatado', 9.8, 0, 6.2, 200, 'ml').toJson());
      await meal.add(db, const Meal('Batata frita', 35.6, 13.1, 5, 100, 'g').toJson());
      await meal.add(db, const Meal('Budweiser', 9.38, 0, 0, 330, 'ml').toJson());
      await meal.add(db, const Meal('Iogurte grego (Carolina)', 12, 6.8, 5.1, 100, 'g').toJson());
      await meal.add(db, const Meal('Melancia', 8.1, 0, 0.9, 100, 'g').toJson());
      await meal.add(db, const Meal('Contrafilé ', 0, 4.5, 35.9, 100, 'g').toJson());
      await meal.add(db, const Meal('Coxa de frango (s/pele, s/osso)', 0, 5.5, 17.8, 100, 'g').toJson());
      await meal.add(db, const Meal('Fraldinha', 0, 5, 36.1, 100, 'g').toJson());
      await meal.add(db, const Meal('Asinha de frango assada (s/pele, s/osso)', 0, 1.37, 5.14, 1, 'uni').toJson());
      await meal.add(db, const Meal('Cupim assado', 0, 24.2, 16.7, 100, 'g').toJson());
      await meal.add(db, const Meal('Molho de salada', 1, 3, 0, 1, 'colher').toJson());
      await meal.add(db, const Meal('Acém cozido', 0.64, 10.9, 27.3, 100, 'g').toJson());
      await meal.add(db, const Meal('Batata cozida', 20, 0.1, 1.71, 100, 'g').toJson());
      await meal.add(db, const Meal('Cenoura cozida', 6.7, 0.2, 0.8, 100, 'g').toJson());
      await meal.add(db, const Meal('Coxinha pequena', 7.38, 3, 2.4, 1, 'uni').toJson());
      await meal.add(db, const Meal('Doguinho', 30, 12, 9, 130, 'g').toJson());
      await meal.add(db, const Meal('Catupiry', 0.3, 1.3, 1, 10, 'g').toJson());
      await meal.add(db, const Meal('Picanha', 0, 11.3, 31.9, 100, 'g').toJson());
      await meal.add(db, const Meal('Pastel mini', 7, 0.85, 1.1, 1, 'uni').toJson());
      await meal.add(db, const Meal('Abacaxi assado', 22, 0.1, 0.7, 1, 'fatia').toJson());
      await meal.add(db, const Meal('Brocolis', 4.4, 0.5, 2.1, 100, 'g').toJson());
      await meal.add(db, const Meal('Couve flor', 4, 3.3, 1.7, 100, 'g').toJson());
      await meal.add(db, const Meal('Pão de queijo ', 22.4, 11, 5, 70, 'g').toJson());
      await meal.add(db, const Meal('Bacon', 0.11, 3.34, 2.96, 1, 'fatia').toJson());
      await meal.add(db, const Meal('Amendoim crocante', 9.2, 8, 4.7, 25, 'g').toJson());
      await meal.add(db, const Meal('Whey morango (Integralmed)', 4.5, 1.9, 21, 1, 'dose').toJson());
      await meal.add(db, const Meal('Whey bar morango (Integralmed)', 14, 3.7, 16, 1, 'uni').toJson());
      await meal.add(db, const Meal('Batata gratinada', 13.4, 7.6, 3.2, 100, 'g').toJson());
      await meal.add(db, const Meal('Frango recheado', 13, 12, 15, 1, 'uni').toJson());
      await meal.add(db, const Meal('Whooper Furioso', 59, 32, 49, 1, 'uni').toJson());
      await meal.add(db, const Meal('Carolina de chocolate', 16, 6.5, 2.9, 50, 'g').toJson());
      await meal.add(db, const Meal('Bolinho carne moída', 4, 11, 14.2, 58, 'g').toJson());
      await meal.add(db, const Meal('Iogurte morango batavo', 16, 2, 1.9, 1, 'uni').toJson());
      await meal.add(db, const Meal('Tortilha', 18.3, 2, 2.66, 38, 'g').toJson());
      await meal.add(db, const Meal('Chilli', 8.67, 3.27, 9.73, 100, 'g').toJson());
      await meal.add(db, const Meal('Pimentão amarelo', 6.32, 0.21, 1, 100, 'g').toJson());
      await meal.add(db, const Meal('Molho chipotle', 0, 8.4, 0, 12, 'g').toJson());
      await meal.add(db, const Meal('Cebola caramelizada', 13, 0, 0, 20, 'g').toJson());
      await meal.add(db, const Meal('Carne moída', 0, 5.4, 13.38, 50, 'g').toJson());
      await meal.add(db, const Meal('Pipoca grande', 185, 8, 25, 200, 'g').toJson());
      await meal.add(db, const Meal('Salame Seara Gourmet', 1, 16, 13, 50, 'g').toJson());
      await meal.add(db, const Meal('Lasanha Bolonhesa ', 15.8, 9.3, 15.4, 100, 'g').toJson());
      await meal.add(db, const Meal('Calabresa', 0, 30, 14, 100, 'g').toJson());
      await meal.add(db, const Meal('Chocolate Lindt', 11, 12, 1.2, 25, 'g').toJson());
      await meal.add(db, const Meal('Beringela', 8.3, 3.8, 0.79, 100, 'g').toJson());
      await meal.add(db, const Meal('Azeitona', 0, 3, 0, 20, 'g').toJson());
      await meal.add(db, const Meal('Pimentão verde', 4.64, 0.17, 0.86, 100, 'g').toJson());
      await meal.add(db, const Meal('Antepasto de beringera', 2, 5.8, 0.25, 50, 'g').toJson());
      await meal.add(db, const Meal('Whey 3w integralmed', 3.2, 1.9, 22, 1, 'dose').toJson());
      await meal.add(db, const Meal('Toddy', 18, 0, 0, 20, 'g').toJson());
      await meal.add(db, const Meal('Farofa de ovo', 64.26, 6.18, 2.78, 100, 'g').toJson());
      await meal.add(db, const Meal('Clara de ovo', 0.22, 0.05, 3.27, 1, 'uni').toJson());
      await meal.add(db, const Meal('Tomate cereja', 0.29, 0.03, 0.17, 1, 'uni').toJson());
      await meal.add(db, const Meal('Chocolate 85%', 1, 2.2, 0.58, 5, 'g').toJson());
      await meal.add(db, const Meal('Chocolate 70%', 1.84, 2, 0.38, 5, 'g').toJson());
      await meal.add(db, const Meal('Chocolate café', 2.6, 1.76, 0.34, 5, 'g').toJson());
      await meal.add(db, const Meal('Fricasse de Frango', 3.42, 7.47, 11.85, 100, 'g').toJson());
      await meal.add(db, const Meal('Batata palha', 11, 9.9, 1.3, 25, 'g').toJson());
      await meal.add(db, const Meal('Pão de leite', 30, 0, 3, 2, 'fatia').toJson());
      await meal.add(db, const Meal('Pão integral Visconti', 24, 2, 4.6, 2, 'fatia').toJson());
      await meal.add(db, const Meal('Chocolate 60% Lacta', 9.8, 8.9, 2.1, 25, 'g').toJson());
      await meal.add(db, const Meal('Creme de milho', 20.4, 1.66, 3.02, 100, 'g').toJson());
      await meal.add(db, const Meal('Champignon', 5, 3.2, 1.87, 100, 'g').toJson());
      await meal.add(db, const Meal('Cochão mole', 0, 9.3, 21.59, 100, 'g').toJson());
      await meal.add(db, const Meal('Esfiha Calabresa', 17, 4.8, 5.1, 1, 'uni').toJson());
      await meal.add(db, const Meal('Esfiha Carne', 20, 7.9, 5.4, 1, 'uni').toJson());
      await meal.add(db, const Meal('Purê de batata com queijo', 17.7, 4.36, 1.8, 100, 'g').toJson());
      await meal.add(db, const Meal('Pão integral bauduco', 22, 2.1, 4.8, 2, 'fatia').toJson());
      await meal.add(db, const Meal('Chocolate 70% Arcor', 7.8, 9.3, 2.8, 25, 'g').toJson());
      await meal.add(db, const Meal('Abacaxi', 9.23, 0.08, 0.68, 1, 'fatia média').toJson());
      await meal.add(db, const Meal('Vagem', 3.94, 0.14, 0.95, 50, 'g').toJson());
      await meal.add(db, const Meal('Chesburger Madero FIT', 36, 23, 26, 1, 'uni').toJson());
      await meal.add(db, const Meal('Chessburger Mac', 30, 12, 15, 1, 'uni').toJson());
      await meal.add(db, const Meal('Tomate', 0.78, 0.04, 0.18, 1, 'fatia').toJson());
      await meal.add(db, const Meal('Pêssego', 6.78, 0.007, 0.23, 1, 'uni').toJson());
      await meal.add(db, const Meal('Salsicha Perdigão', 2.2, 10, 6.2, 50, 'g').toJson());
      await meal.add(db, const Meal('Maionese Heinz', 0, 8.7, 0, 12, 'g').toJson());
      await meal.add(db, const Meal('Catchup Heinz', 3.3, 0, 0, 12, 'g').toJson());
      await meal.add(db, const Meal('Tilápia à milanesa', 8.45, 7.15, 13.06, 100, 'g').toJson());
      await meal.add(db, const Meal('Arroz com frango', 13, 4.7, 18.24, 100, 'g').toJson());
      await meal.add(db, const Meal('Purê de mandioquinha', 8.4, 4.13, 0.39, 40, 'g').toJson());
      await meal.add(db, const Meal('Chocotone Bauduco', 39, 7.8, 5.6, 80, 'g').toJson());
      await meal.add(db, const Meal('Pão de Mel Bauducco', 21, 2.5, 2.2, 1, 'uni').toJson());
      await meal.add(db, const Meal('Risoto tomate seco', 24.3, 5.72, 4.25, 100, 'g').toJson());
      await meal.add(db, const Meal('Casquinha BK', 32, 6, 3, 1, 'uni').toJson());
      oldVersion++;
    }

    if (oldVersion == 1) {
      // no changes
      oldVersion++;
    }

    if (oldVersion == 2) {
      // no changes
      oldVersion++;
    }
  }
}
