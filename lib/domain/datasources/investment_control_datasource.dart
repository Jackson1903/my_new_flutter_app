import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/domain/datasources/investment_local_datasource.dart';
import 'package:my_new_flutter_app/domain/datasources/investment_remote_datasource.dart';
import 'package:my_new_flutter_app/data/repositories/investment_repository.dart';

class InvestmentRepository extends InvestmentRepositoryContract {
  final InvestmentRemoteDataSource _remoteDataSource;
  final InvestmentLocalDataSource _localDataSource;

  // Constructor que recibe ambos datasources como dependencias
  InvestmentRepository({
    required InvestmentRemoteDataSource remoteDataSource,
    required InvestmentLocalDataSource localDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  Future<List<CardInvestment>> fetchInvestments() async {
    try {
      // Intentar obtener datos del servidor
      final remoteInvestments = await _remoteDataSource.getAllInvestments();

      // Si es exitoso, guardar en caché local
      await _localDataSource.saveInvestments(remoteInvestments);

      return remoteInvestments;
    } catch (e) {
      // Si falla el servidor, usar datos locales como fallback
      print('Error fetching remote data: $e');
      print('Using local data as fallback...');
      return await _localDataSource.getAllInvestments();
    }
  }

  Future<CardInvestment> addInvestment(CardInvestment investment) async {
    try {
      // Intentar agregar al servidor
      final addedInvestment = await _remoteDataSource.addInvestment(investment);

      // Si es exitoso, agregar también localmente
      await _localDataSource.addInvestment(addedInvestment);

      return addedInvestment;
    } catch (e) {
      // Si falla el servidor, agregar solo localmente
      print('Error adding to remote: $e');
      print('Adding to local storage only...');
      await _localDataSource.addInvestment(investment);
      return investment;
    }
  }

  @override
  Future<CardInvestment> updateInvestment(CardInvestment investment) async {
    try {
      // Intentar actualizar en el servidor
      final updatedInvestment = await _remoteDataSource.updateInvestment(investment);

      // Si es exitoso, actualizar también localmente
      await _localDataSource.updateInvestment(updatedInvestment);

      return updatedInvestment;
    } catch (e) {
      // Si falla el servidor, actualizar solo localmente
      print('Error updating remote: $e');
      print('Updating local storage only...');
      await _localDataSource.updateInvestment(investment);
      return investment;
    }
  }

  @override
  Future<bool> deleteInvestment(String id) async {
    try {
      // Intentar eliminar del servidor
      final success = await _remoteDataSource.deleteInvestment(id);

      if (success) {
        // Si es exitoso, eliminar también localmente
        await _localDataSource.deleteInvestment(id);
      }

      return success;
    } catch (e) {
      // Si falla el servidor, eliminar solo localmente
      print('Error deleting from remote: $e');
      print('Deleting from local storage only...');
      return await _localDataSource.deleteInvestment(id);
    }
  }

  // Método para obtener datos locales directamente
  Future<List<CardInvestment>> getLocalInvestments() async {
    return await _localDataSource.getAllInvestments();
  }

  // Método para forzar sincronización
  Future<void> syncWithRemote() async {
    try {
      final remoteInvestments = await _remoteDataSource.getAllInvestments();
      await _localDataSource.saveInvestments(remoteInvestments);
    } catch (e) {
      throw Exception('Failed to sync with remote: $e');
    }
  }

  // Métodos adicionales que aprovechan ambos datasources
  Future<CardInvestment> getInvestmentById(String id) async {
    try {
      // Intentar obtener del servidor
      return await _remoteDataSource.getInvestmentById(id);
    } catch (e) {
      // Fallback a datos locales
      return await _localDataSource.getInvestmentById(id);
    }
  }

  Future<List<CardInvestment>> getInvestmentsByType(String type) async {
    try {
      // Intentar obtener del servidor
      return await _remoteDataSource.getInvestmentsByType(type);
    } catch (e) {
      // Fallback a datos locales
      return await _localDataSource.getInvestmentsByType(type);
    }
  }

  Future<double> getTotalInvestmentAmount() async {
    // Para estadísticas, usar datos locales (más rápido)
    return await _localDataSource.getTotalInvestmentAmount();
  }

  // Método para obtener estadísticas completas
  Future<Map<String, dynamic>> getInvestmentStatistics() async {
    final total = await _localDataSource.getTotalInvestmentAmount();
    final countByType = await _localDataSource.getInvestmentCountByType();
    final amountByType = await _localDataSource.getInvestmentAmountByType();
    final highest = await _localDataSource.getHighestInvestment();
    final lowest = await _localDataSource.getLowestInvestment();

    return {
      'total_amount': total,
      'count_by_type': countByType,
      'amount_by_type': amountByType,
      'highest_investment': highest?.toMap(),
      'lowest_investment': lowest?.toMap(),
    };
  }

  @override
  Future<List<CardInvestment>> searchInvestments(String query) async {
    try {
      // Intentar buscar en el servidor
      final remoteDataSource = _remoteDataSource as InvestmentRemoteDataSourceImpl;
      return await remoteDataSource.searchInvestments(query);
    } catch (e) {
      // Fallback: buscar localmente por nombre
      final allInvestments = await _localDataSource.getAllInvestments();
      return allInvestments
          .where((investment) =>
              investment.cardName.toLowerCase().contains(query.toLowerCase()) ||
              investment.cardType.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Future<List<CardInvestment>> getInvestmentsByAmountRange(double min, double max) async {
    // Para filtros específicos, usar datos locales (más eficiente)
    final allInvestments = await _localDataSource.getAllInvestments();
    return allInvestments
        .where((investment) =>
            investment.investmentAmount >= min && investment.investmentAmount <= max)
        .toList();
  }

  @override
  Future<List<CardInvestment>> getRecentInvestments(int limit) async {
    // Para obtener recientes, usar datos locales y tomar los últimos
    final allInvestments = await _localDataSource.getAllInvestments();
    final recentCount = allInvestments.length < limit ? allInvestments.length : limit;
    return allInvestments.reversed.take(recentCount).toList();
  }

  @override
  Future<void> clearLocalCache() async {
    await _localDataSource.clearAllInvestments();
  }

  @override
  Future<void> clearAllData() async {
    // Limpiar datos locales
    await _localDataSource.clearAllInvestments();

    // Nota: Para limpiar datos remotos, necesitarías un endpoint específico en tu API
    // Por ahora solo limpiamos local
    print('Local data cleared. Remote data clearing would require API endpoint.');
  }
}
