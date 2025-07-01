import 'package:my_new_flutter_app/data/investment.dart';
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
    return List.from(investments); // Retorna una copia para evitar modificaciones accidentales
  }

  @override
  Future<CardInvestment> getInvestmentById(String id) async {
    await Future.delayed(const Duration(milliseconds: 50));

    try {
      final investment = investments.firstWhere(
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
    final exists = investments.any((inv) => inv.cardId == investment.cardId);
    if (exists) {
      throw Exception('Ya existe una inversión con el ID: ${investment.cardId}');
    }

    investments.add(investment);
  }

  @override
  Future<void> updateInvestment(CardInvestment investment) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = investments.indexWhere((inv) => inv.cardId == investment.cardId);
    if (index == -1) {
      throw Exception('Inversión no encontrada para actualizar');
    }

    investments[index] = investment;
  }

  @override
  Future<bool> deleteInvestment(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));

    final index = investments.indexWhere((inv) => inv.cardId == id);
    if (index == -1) {
      return false; // No encontrada
    }

    investments.removeAt(index);
    return true;
  }

  @override
  Future<List<CardInvestment>> getInvestmentsByType(String type) async {
    await Future.delayed(const Duration(milliseconds: 80));

    return investments.where((investment) => investment.cardType == type).toList();
  }

  @override
  Future<double> getTotalInvestmentAmount() async {
    await Future.delayed(const Duration(milliseconds: 50));

    double total = 0.0;
    for (final investment in investments) {
      total += investment.investmentAmount;
    }
    return total;
  }

  @override
  Future<void> clearAllInvestments() async {
    await Future.delayed(const Duration(milliseconds: 100));
    investments.clear();
  }

  @override
  Future<void> saveInvestments(List<CardInvestment> newInvestments) async {
    await Future.delayed(const Duration(milliseconds: 150));

    // Reemplazar toda la lista con los nuevos datos
    investments.clear();
    investments.addAll(newInvestments);
  }

  // Métodos adicionales para estadísticas locales
  Future<Map<String, int>> getInvestmentCountByType() async {
    await Future.delayed(const Duration(milliseconds: 80));

    final Map<String, int> countByType = {};
    for (final investment in investments) {
      countByType[investment.cardType] = (countByType[investment.cardType] ?? 0) + 1;
    }
    return countByType;
  }

  Future<Map<String, double>> getInvestmentAmountByType() async {
    await Future.delayed(const Duration(milliseconds: 80));

    final Map<String, double> amountByType = {};
    for (final investment in investments) {
      amountByType[investment.cardType] =
          (amountByType[investment.cardType] ?? 0.0) + investment.investmentAmount;
    }
    return amountByType;
  }

  Future<CardInvestment?> getHighestInvestment() async {
    await Future.delayed(const Duration(milliseconds: 50));

    if (investments.isEmpty) return null;

    return investments.reduce(
        (current, next) => current.investmentAmount > next.investmentAmount ? current : next);
  }

  Future<CardInvestment?> getLowestInvestment() async {
    await Future.delayed(const Duration(milliseconds: 50));

    if (investments.isEmpty) return null;

    return investments.reduce(
        (current, next) => current.investmentAmount < next.investmentAmount ? current : next);
  }
}
