import '../../data/models/investment.dart';

abstract class InvestmentDataSource {
  Future<List<Investment>> getAllInvestments();
  Future<void> addInvestment(Investment investment);
}
