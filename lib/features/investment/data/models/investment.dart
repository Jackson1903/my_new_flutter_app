import 'package:freezed_annotation/freezed_annotation.dart';

part 'investment.freezed.dart';
part 'investment.g.dart';

@freezed
class Investment with _$Investment {
  factory Investment({
    @JsonKey(name: 'id') required String cardId,
    @JsonKey(name: 'name') required String cardName,
    @JsonKey(name: 'type') required String cardType,
    @JsonKey(name: 'amount') required String investmentAmount,
  }) = _Investment;

  factory Investment.fromJson(Map<String, dynamic> json) => _$InvestmentFromJson(json);
}
