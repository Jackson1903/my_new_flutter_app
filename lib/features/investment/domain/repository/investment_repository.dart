import '../../data/models/investment.dart';

abstract class InvestmentRepository {
  Future<List<Investment>> getAllInvestments();
  Future<void> addInvestment(Investment investment);
}
