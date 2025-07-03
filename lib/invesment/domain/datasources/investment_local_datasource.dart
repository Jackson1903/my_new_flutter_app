import '../../models/investment.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';

abstract class InvestmentLocalDataSource {
  Future<List<CardInvestment>> getAllInvestments();
  Future<CardInvestment> getInvestmentById(String id);
  Future<void> addInvestment(CardInvestment investment);
  Future<void> updateInvestment(CardInvestment investment);
  Future<bool> deleteInvestment(String id);
  Future<List<CardInvestment>> getInvestmentsByType(String type);
  Future<double> getTotalInvestmentAmount();
  Future<void> clearAllInvestments();
  Future<void> saveInvestments(List<CardInvestment> investments);

  // Métodos adicionales para estadísticas
  Future<Map<String, int>> getInvestmentCountByType();
  Future<Map<String, double>> getInvestmentAmountByType();
  Future<CardInvestment?> getHighestInvestment();
  Future<CardInvestment?> getLowestInvestment();
}

class InvestmentLocalDataSourceImpl implements InvestmentLocalDataSource {
  // Simulación de almacenamiento local (en una app real sería SharedPreferences, Hive, SQLite, etc.)

  @override
  Future<List<CardInvestment>> getAllInvestments() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return List.from(investmentsFromJson(
        'lib/assets/investment.json')); // Retorna una copia para evitar modificaciones accidentales
  }

  @override
  Future<CardInvestment> getInvestmentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      final investment = investmentsFromJson('lib/assets/investment.json').firstWhere(
        (investment) => investment.cardId == id,
      );
      return investment;
    } catch (e) {
      throw Exception('Inversión no encontrada con ID: $id');
    }
  }

  @override
  Future<void> addInvestment(CardInvestment investment) async {
    await Future.delayed(const Duration(milliseconds: 100));

    // Verificar que no exista una inversión con el mismo ID
    final exists = investmentsFromJson('lib/assets/investment.json')
        .any((inv) => inv.cardId == investment.cardId);
    if (exists) {
      throw Exception('Ya existe una inversión con el ID: ${investment.cardId}');
    }

    investmentsFromJson('lib/assets/investment.json').add(investment);
  }

  @override
  Future<void> updateInvestment(CardInvestment investment) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = investmentsFromJson('lib/assets/investment.json')
        .indexWhere((inv) => inv.cardId == investment.cardId);
    if (index == -1) {
      throw Exception('Inversión no encontrada para actualizar');
    }

    investmentsFromJson('lib/assets/investment.json')[index] = investment;
  }

  @override
  Future<bool> deleteInvestment(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index =
        investmentsFromJson('lib/assets/investment.json').indexWhere((inv) => inv.cardId == id);
    if (index == -1) {
      return false; // No encontrada
    }

    investmentsFromJson('lib/assets/investment.json').removeAt(index);
    return true;
  }

  @override
  Future<List<CardInvestment>> getInvestmentsByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 80));

    return investmentsFromJson('lib/assets/investment.json')
        .where((investment) => investment.cardType == type)
        .toList();
  }

  @override
  Future<double> getTotalInvestmentAmount() async {
    await Future.delayed(const Duration(milliseconds: 50));

    double total = 0.0;
    for (final investment in investmentsFromJson('lib/assets/investment.json')) {
      total += investment.investmentAmount;
    }
    return total;
  }

  @override
  Future<void> clearAllInvestments() async {
    await Future.delayed(const Duration(milliseconds: 100));
    investmentsFromJson('lib/assets/investment.json').clear();
  }

  @override
  Future<void> saveInvestments(List<CardInvestment> newInvestments) async {
    await Future.delayed(const Duration(milliseconds: 150));

    // Reemplazar toda la lista con los nuevos datos
    investmentsFromJson('lib/assets/investment.json').clear();
    investmentsFromJson('lib/assets/investment.json').addAll(newInvestments);
  }

  // Métodos adicionales para estadísticas locales
  Future<Map<String, int>> getInvestmentCountByType() async {
    await Future.delayed(const Duration(milliseconds: 80));

    final Map<String, int> countByType = {};
    for (final investment in investmentsFromJson('lib/assets/investment.json')) {
      countByType[investment.cardType] = (countByType[investment.cardType] ?? 0) + 1;
    }
    return countByType;
  }

  Future<Map<String, double>> getInvestmentAmountByType() async {
    await Future.delayed(const Duration(milliseconds: 80));

    final Map<String, double> amountByType = {};
    for (final investment in investmentsFromJson('lib/assets/investment.json')) {
      amountByType[investment.cardType] =
          (amountByType[investment.cardType] ?? 0.0) + investment.investmentAmount;
    }
    return amountByType;
  }

  Future<CardInvestment?> getHighestInvestment() async {
    await Future.delayed(const Duration(milliseconds: 50));

    if (investmentsFromJson('lib/assets/investment.json').isEmpty) return null;

    return investmentsFromJson('lib/assets/investment.json').reduce(
        (current, next) => current.investmentAmount > next.investmentAmount ? current : next);
  }

  Future<CardInvestment?> getLowestInvestment() async {
    await Future.delayed(const Duration(milliseconds: 50));

    if (investmentsFromJson('lib/assets/investment.json').isEmpty) return null;

    return investmentsFromJson('lib/assets/investment.json').reduce(
        (current, next) => current.investmentAmount < next.investmentAmount ? current : next);
  }
}
