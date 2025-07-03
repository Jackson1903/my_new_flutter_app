import 'package:my_new_flutter_app/domain/datasources/investment_local_datasource.dart';
import 'package:my_new_flutter_app/domain/datasources/investment_remote_datasource.dart';
import 'package:my_new_flutter_app/data/providers/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasource_providers.g.dart';

@Riverpod(keepAlive: true)
InvestmentLocalDataSource investmentLocalDataSource(InvestmentLocalDataSourceRef ref) {
  return InvestmentLocalDataSourceImpl();
}

@Riverpod(keepAlive: true)
InvestmentRemoteDataSource investmentRemoteDataSource(InvestmentRemoteDataSourceRef ref) {
  final dio = ref.watch(dioProvider);
  return InvestmentRemoteDataSourceImpl(dio: dio);
}
