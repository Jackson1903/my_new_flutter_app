import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_investment.freezed.dart';
part 'card_investment.g.dart';

@freezed
class CardInvestment with _$CardInvestment {
  factory CardInvestment({
    required String cardId,
    required String cardName,
    required String cardType,
    required double investmentAmount,
    @Default(DateTime.now) DateTime createdAt,
    @Default(false) bool isActive,
  }) = _CardInvestment;

  // Constructor con valores por defecto
  factory CardInvestment.create({
    required String cardName,
    required String cardType,
    required double investmentAmount,
  }) {
    return CardInvestment(
      cardId: DateTime.now().millisecondsSinceEpoch.toString(),
      cardName: cardName,
      cardType: cardType,
      investmentAmount: investmentAmount,
      createdAt: DateTime.now(),
      isActive: true,
    );
  }

  factory CardInvestment.fromJson(Map<String, dynamic> json) => _$CardInvestmentFromJson(json);
}

// Extensión para métodos adicionales
extension CardInvestmentX on CardInvestment {
  // Getter para determinar si es una inversión grande
  bool get isLargeInvestment => investmentAmount > 1000000;

  // Getter para obtener el tipo de inversión formateado
  String get formattedType {
    switch (cardType) {
      case 'FI':
        return 'Fondo de Inversión';
      case 'FP':
        return 'Fondo de Pensiones';
      case 'BO':
        return 'Bonos';
      case 'CE':
        return 'Certificados';
      case 'AC':
        return 'Acciones';
      default:
        return cardType;
    }
  }

  // Método para obtener el monto formateado
  String get formattedAmount {
    return '₡${investmentAmount.toStringAsFixed(2)}';
  }

  // Método para validar la inversión
  bool get isValid {
    return cardId.isNotEmpty && cardName.isNotEmpty && cardType.isNotEmpty && investmentAmount > 0;
  }

  // Método para crear una copia con ID actualizado
  CardInvestment withNewId() {
    return copyWith(cardId: DateTime.now().millisecondsSinceEpoch.toString());
  }
}
