import 'package:dio/dio.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';
import 'package:my_new_flutter_app/data/investments.dart';

class InvestmentRepository {
  final Dio _dio = Dio();
  final String _baseUrl = 'http://localhost:3000';

  InvestmentRepository() {
    // Configurar timeout y opciones del cliente HTTP
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
  }

  Future<List<CardInvestment>> fetchInvestments() async {
    try {
      final response = await _dio.get('$_baseUrl/getInvestments');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CardInvestment.fromMap(item)).toList();
      } else {
        throw Exception('Failed to load investments: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout - using local data');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout - using local data');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to load investments: $e');
    }
  }

  Future<CardInvestment> addInvestment(CardInvestment investment) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/investments',
        data: investment.toMap(),
      );
      if (response.statusCode == 201) {
        return CardInvestment.fromMap(response.data);
      } else {
        throw Exception('Failed to add investment: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error adding investment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to add investment: $e');
    }
  }

  Future<CardInvestment> updateInvestment(CardInvestment investment) async {
    try {
      final response = await _dio.put(
        '$_baseUrl/investments/${investment.cardId}',
        data: investment.toMap(),
      );
      if (response.statusCode == 200) {
        return CardInvestment.fromMap(response.data);
      } else {
        throw Exception('Failed to update investment: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error updating investment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to update investment: $e');
    }
  }

  Future<bool> deleteInvestment(String id) async {
    try {
      final response = await _dio.delete('$_baseUrl/investments/$id');
      return response.statusCode == 204 || response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Network error deleting investment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete investment: $e');
    }
  }

  // Método para obtener datos locales como fallback
  Future<List<CardInvestment>> getLocalInvestments() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return investments;
  }
}
