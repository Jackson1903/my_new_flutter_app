import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_new_flutter_app/features/investment/data/datasources/investment_datasource.dart';
import 'package:my_new_flutter_app/features/investment/data/models/investment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/datasource/investment_datasource.dart';
import '../../domain/repository/investment_repository.dart';

part 'investment_repository_impl.g.dart';

class InvestmentRepositoryImpl implements InvestmentRepository {
  final InvestmentDataSource _dataSource;

  InvestmentRepositoryImpl({
    required InvestmentDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<List<Investment>> getAllInvestments() async {
    try {
      return await _dataSource.getAllInvestments();
    } catch (e) {
      debugPrint('Repository error getting all investments: $e');
      rethrow;
    }
  }

  @override
  // Método para agregar una nueva inversión
  Future<void> addInvestment(Investment investment) async {
    try {
      return await _dataSource.addInvestment(investment);
    } catch (e) {
      debugPrint('Repository error getting all investments: $e');
      rethrow;
    }
  }
}

@riverpod
InvestmentRepository investmentRepository(Ref ref) {
  final dataSource = ref.watch(investmentDataSourceProvider);
  return InvestmentRepositoryImpl(dataSource: dataSource);
}
