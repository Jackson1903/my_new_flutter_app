import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/data/repositories/investment_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'get_investment_provider.g.dart';

@riverpod
class GetInvestmentProvider extends _$GetInvestmentProvider {
  late final InvestmentRepository _repository;

  @override
  Future<List<CardInvestment>> build() async {
    // Inicializar el repository
    _repository = InvestmentRepository();

    try {
      // Intentar obtener inversiones del servidor
      final serverInvestments = await _repository.fetchInvestments();
      return serverInvestments;
    } catch (e) {
      // Si falla la conexión al servidor, usar datos locales
      print('Error al conectar con el servidor: $e');
      print('Usando datos locales...');
      return await _repository.getLocalInvestments();
    }
  }
}
