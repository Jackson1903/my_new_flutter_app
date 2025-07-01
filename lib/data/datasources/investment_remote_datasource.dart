import 'package:dio/dio.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';

abstract class InvestmentRemoteDataSource {
  Future<List<CardInvestment>> getAllInvestments();
  Future<CardInvestment> getInvestmentById(String id);
  Future<CardInvestment> addInvestment(CardInvestment investment);
  Future<CardInvestment> updateInvestment(CardInvestment investment);
  Future<bool> deleteInvestment(String id);
  Future<List<CardInvestment>> getInvestmentsByType(String type);
}

class InvestmentRemoteDataSourceImpl implements InvestmentRemoteDataSource {
  final Dio _dio;

  InvestmentRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<List<CardInvestment>> getAllInvestments() async {
    try {
      final response = await _dio.get('/getInvestments');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CardInvestment.fromMap(item)).toList();
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
  Future<CardInvestment> getInvestmentById(String id) async {
    try {
      final response = await _dio.get('/investments/$id');
      if (response.statusCode == 200) {
        return CardInvestment.fromMap(response.data);
      } else {
        throw Exception('Failed to get investment: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error getting investment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get investment: $e');
    }
  }

  @override
  Future<CardInvestment> addInvestment(CardInvestment investment) async {
    try {
      final response = await _dio.post(
        '/investments',
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

  @override
  Future<CardInvestment> updateInvestment(CardInvestment investment) async {
    try {
      final response = await _dio.put(
        '/investments/${investment.cardId}',
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

  @override
  Future<bool> deleteInvestment(String id) async {
    try {
      final response = await _dio.delete('/investments/$id');
      return response.statusCode == 204 || response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Network error deleting investment: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete investment: $e');
    }
  }

  @override
  Future<List<CardInvestment>> getInvestmentsByType(String type) async {
    try {
      final response = await _dio.get('/investments', queryParameters: {'type': type});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CardInvestment.fromMap(item)).toList();
      } else {
        throw Exception('Failed to load investments by type: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error getting investments by type: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get investments by type: $e');
    }
  }

  // Métodos adicionales para funcionalidades específicas del servidor
  Future<Map<String, dynamic>> getInvestmentStats() async {
    try {
      final response = await _dio.get('/investments/stats');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to get stats: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error getting stats: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get stats: $e');
    }
  }

  Future<List<CardInvestment>> searchInvestments(String query) async {
    try {
      final response = await _dio.get('/investments/search', queryParameters: {'q': query});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => CardInvestment.fromMap(item)).toList();
      } else {
        throw Exception('Failed to search investments: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error searching investments: ${e.message}');
    } catch (e) {
      throw Exception('Failed to search investments: $e');
    }
  }
}
