import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/data/repositories/investment_repository_contract.dart';
import 'package:my_new_flutter_app/data/repositories/investment_repository.dart';
import 'package:my_new_flutter_app/data/datasources/investment_local_datasource.dart';
import 'package:my_new_flutter_app/data/datasources/investment_remote_datasource.dart';
import 'package:my_new_flutter_app/data/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_investment_provider.g.dart';

@riverpod
class GetInvestmentProvider extends _$GetInvestmentProvider {
  InvestmentRepositoryContract? _repository;

  // Getter para el repository que se inicializa cuando es necesario
  InvestmentRepositoryContract get repository {
    if (_repository == null) {
      // Crear datasources
      final dio = ref.read(dioProvider);
      final remoteDataSource = InvestmentRemoteDataSourceImpl(dio: dio);
      final localDataSource = InvestmentLocalDataSourceImpl();

      // Crear repository con datasources
      _repository = InvestmentRepository(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
      );
    }
    return _repository!;
  }

  @override
  Future<List<CardInvestment>> build() async {
    try {
      // Usar el repository que maneja ambos datasources
      final investments = await repository.fetchInvestments();
      return investments;
    } catch (e) {
      // Si falla completamente, usar datos locales
      print('Error en build: $e');
      return await repository.getLocalInvestments();
    }
  }

  // Método para agregar una nueva inversión
  Future<void> addInvestment(CardInvestment investment) async {
    try {
      await repository.addInvestment(investment);
      // Refrescar el estado después de agregar
      ref.invalidateSelf();
    } catch (e) {
      print('Error al agregar inversión: $e');
      rethrow;
    }
  }

  // Método para actualizar una inversión existente
  Future<void> updateInvestment(CardInvestment investment) async {
    try {
      await repository.updateInvestment(investment);
      // Refrescar el estado después de actualizar
      ref.invalidateSelf();
    } catch (e) {
      print('Error al actualizar inversión: $e');
      rethrow;
    }
  }

  // Método para eliminar una inversión
  Future<void> deleteInvestment(String id) async {
    try {
      await repository.deleteInvestment(id);
      // Refrescar el estado después de eliminar
      ref.invalidateSelf();
    } catch (e) {
      print('Error al eliminar inversión: $e');
      rethrow;
    }
  }

  // Método para refrescar manualmente los datos
  Future<void> refresh() async {
    ref.invalidateSelf();
  }

  // Método para sincronizar con el servidor
  Future<void> syncWithRemote() async {
    try {
      await repository.syncWithRemote();
      ref.invalidateSelf();
    } catch (e) {
      print('Error al sincronizar: $e');
      rethrow;
    }
  }

  // Método para obtener estadísticas
  Future<Map<String, dynamic>> getStatistics() async {
    return await repository.getInvestmentStatistics();
  }

  // Método para obtener inversiones por tipo
  Future<List<CardInvestment>> getInvestmentsByType(String type) async {
    return await repository.getInvestmentsByType(type);
  }
}
