import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/investment.dart';
import '../../data/repositories/investment_repository_impl.dart';

part 'investment_viewmodel.g.dart';

// ViewModel para manejar la lista de inversiones
@riverpod
class InvestmentViewModel extends _$InvestmentViewModel {
  @override
  Future<List<Investment>> build() async {
    final repository = ref.watch(investmentRepositoryProvider);
    return await repository.getAllInvestments();
  }
}
