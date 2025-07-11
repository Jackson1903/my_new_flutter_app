import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/dio_provider.dart';
import '../../domain/datasource/investment_datasource.dart';
import '../../domain/repository/investment_repository.dart';
import '../models/investment.dart';

part 'investment_datasource.g.dart';

class InvestmentDataSourceImpl implements InvestmentDataSource {
  final Dio _dio;
  InvestmentRepository? _repository;
  get ref => null;

  InvestmentRepository get repository {
    return _repository!;
  }

  InvestmentDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<Investment>> getAllInvestments() async {
    try {
      final response = await _dio.get('/getInvestments');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Investment.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load investments: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Connection error');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to load investments: $e');
    }
  }

  @override
  Future<void> addInvestment(Investment investment) async {
    try {
      await repository.addInvestment(investment);
      // Refrescar el estado después de agregar
      var ref;
      ref.invalidateSelf();
    } catch (e) {
      debugPrint('Error al agregar inversión: $e');
      rethrow;
    }
  }
}

@riverpod
InvestmentDataSource investmentDataSource(Ref ref) {
  final dio = ref.watch(dioProvider);
  return InvestmentDataSourceImpl(dio: dio);
}
