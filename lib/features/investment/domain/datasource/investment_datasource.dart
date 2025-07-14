import '../../data/models/investment.dart';

abstract class InvestmentDataSource {
  Future<List<Investment>> getAllInvestments();
}
