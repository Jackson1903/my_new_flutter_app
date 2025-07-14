import '../../data/models/investment.dart';

abstract class InvestmentRepository {
  Future<List<Investment>> getAllInvestments();
}
