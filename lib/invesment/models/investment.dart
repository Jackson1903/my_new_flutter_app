import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:my_new_flutter_app/data/datasources/investment_local_datasource.dart';
import 'package:my_new_flutter_app/data/models/card_investment.dart';

import 'package:my_new_flutter_app/assets/investment.json';

// Función para cargar inversiones desde el archivo JSON
Future<List<CardInvestment>> loadInvestmentsFromAssets() async {
  try {
    final String jsonString = await rootBundle.loadString('lib/assets/investment.json');
    final List<dynamic> jsonList = jsonDecode(jsonString);

    return jsonList
        .map((json) => CardInvestment(
              json['id'] as String,
              json['name'] as String,
              json['type'] as String,
              (json['amount'] as num).toDouble(),
            ))
        .toList();
  } catch (e) {
    print('Error loading investments from assets: $e');
    return [];
  }
}

// Función para convertir todas las inversiones a JSON con metadatos
String investmentsToJson() {
  final investmentsList = loadInvestmentsFromAssets()
      .map((investment) => {
            'cardId': investment.cardId,
            'cardName': investment.cardName,
            'cardType': investment.cardType,
            'investmentAmount': investment.investmentAmount,
          })
      .toList();

  final totalAmount = investmentsList.fold(0.0, (sum, inv) => sum + inv.investmentAmount);

  return jsonEncode({
    'investments': investmentsList,
    'metadata': {
      'total_count': investmentsList.length,
      'total_amount': totalAmount,
      'average_amount': totalAmount / investmentsList.length,
      'created_at': DateTime.now().toIso8601String(),
    }
  });
}

extension on Future<List<CardInvestment>> {
  map(Map<String, dynamic> Function(dynamic investment) param0) {}
}

// Función para convertir solo el array de inversiones
String investmentsListToJson() {
  final investmentsList = loadInvestmentsFromAssets()
      .map((investment) => {
            'cardId': investment.cardId,
            'cardName': investment.cardName,
            'cardType': investment.cardType,
            'investmentAmount': investment.investmentAmount,
          })
      .toList();

  return jsonEncode(investmentsList);
}

// Función para convertir una inversión específica a JSON
String investmentToJson(CardInvestment investment) {
  return jsonEncode({
    'cardId': investment.cardId,
    'cardName': investment.cardName,
    'cardType': investment.cardType,
    'investmentAmount': investment.investmentAmount,
  });
}

// Función para crear inversiones desde JSON
List<CardInvestment> investmentsFromJson(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList
      .map((json) => CardInvestment(
            json['cardId'],
            json['cardName'],
            json['cardType'],
            (json['investmentAmount'] as num).toDouble(),
          ))
      .toList();
}
