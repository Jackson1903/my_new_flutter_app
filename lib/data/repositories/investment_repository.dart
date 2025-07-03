import 'package:my_new_flutter_app/data/models/card_investment.dart';

/// Clase abstracta que define el contrato para el repositorio de inversiones
/// Permite múltiples implementaciones (local, remote, mock, etc.)
abstract class InvestmentRepositoryContract {
  // Operaciones CRUD básicas
  Future<List<CardInvestment>> fetchInvestments();
  Future<CardInvestment> addInvestment(CardInvestment investment);
  Future<CardInvestment> updateInvestment(CardInvestment investment);
  Future<bool> deleteInvestment(String id);

  // Operaciones de consulta
  Future<CardInvestment> getInvestmentById(String id);
  Future<List<CardInvestment>> getInvestmentsByType(String type);
  Future<List<CardInvestment>> getLocalInvestments();

  // Operaciones de estadísticas
  Future<double> getTotalInvestmentAmount();
  Future<Map<String, dynamic>> getInvestmentStatistics();

  // Operaciones de sincronización
  Future<void> syncWithRemote();

  // Operaciones de búsqueda (opcional)
  Future<List<CardInvestment>> searchInvestments(String query);

  // Operaciones de filtrado avanzado (opcional)
  Future<List<CardInvestment>> getInvestmentsByAmountRange(double min, double max);
  Future<List<CardInvestment>> getRecentInvestments(int limit);

  // Operaciones de limpieza (opcional)
  Future<void> clearLocalCache();
  Future<void> clearAllData();
}
