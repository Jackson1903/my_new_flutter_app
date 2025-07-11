import 'package:freezed_annotation/freezed_annotation.dart';

part 'investment.freezed.dart';
part 'investment.g.dart';

@freezed
class Investment with _$Investment {
  factory Investment({
    required String cardId,
    required String cardName,
    required String cardType,
    required String investmentAmount,
  }) = _Investment;

  factory Investment.fromJson(Map<String, dynamic> json) {
    return Investment(
      cardId: json['id']?.toString() ?? '',
      cardName: json['name']?.toString() ?? '',
      cardType: json['type']?.toString() ?? '',
      investmentAmount: json['amount']?.toString() ?? '0',
    );
  }
}
