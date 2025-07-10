import 'package:freezed_annotation/freezed_annotation.dart';

part 'investment.freezed.dart';
part 'investment.g.dart';

@freezed
class Investment with _$Investment {
  factory Investment({
    required String cardId,
    required String cardName,
    required String cardType,
    required double investmentAmount,
  }) = _Investment;

  // Constructor con valores por defecto
  factory Investment.create({
    required String cardName,
    required String cardType,
    required double investmentAmount,
  }) {
    return Investment(
      cardId: DateTime.now().millisecondsSinceEpoch.toString(),
      cardName: cardName,
      cardType: cardType,
      investmentAmount: investmentAmount,
    );
  }

  factory Investment.fromJson(Map<String, dynamic> json) => _$InvestmentFromJson(json);
}
