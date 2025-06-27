import 'dart:convert';

class CardInvestment {
  const CardInvestment(
    this.cardId,
    this.cardName,
    this.cardType,
    this.investmentAmount,
  );
  final String cardId;
  final String cardName;
  final String cardType;
  final double investmentAmount;

  // Constructor para crear una instancia desde un Map
  factory CardInvestment.fromMap(Map<String, dynamic> map) {
    return CardInvestment(
      map['cardId'] ?? '',
      map['cardName'] ?? '',
      map['cardType'] ?? '',
      (map['investmentAmount'] ?? 0.0).toDouble(),
    );
  }

  // Método para convertir la instancia a un Map
  Map<String, dynamic> toMap() {
    return {
      'cardId': cardId,
      'cardName': cardName,
      'cardType': cardType,
      'investmentAmount': investmentAmount,
    };
  }

  // Constructor para crear desde JSON string
  factory CardInvestment.fromJson(String source) {
    return CardInvestment.fromMap(json.decode(source));
  }

  // Método para convertir a JSON string
  String toJson() {
    return json.encode(toMap());
  }

  // Método toString para debugging
  @override
  String toString() {
    return 'CardInvestment(cardId: $cardId, cardName: $cardName, cardType: $cardType, investmentAmount: $investmentAmount)';
  }

  // Método copyWith para crear copias con cambios
  CardInvestment copyWith({
    String? cardId,
    String? cardName,
    String? cardType,
    double? investmentAmount,
  }) {
    return CardInvestment(
      cardId ?? this.cardId,
      cardName ?? this.cardName,
      cardType ?? this.cardType,
      investmentAmount ?? this.investmentAmount,
    );
  }
}
