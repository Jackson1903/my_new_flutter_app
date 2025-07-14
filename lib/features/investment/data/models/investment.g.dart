// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvestmentImpl _$$InvestmentImplFromJson(Map<String, dynamic> json) =>
    _$InvestmentImpl(
      cardId: json['id'] as String,
      cardName: json['name'] as String,
      cardType: json['type'] as String,
      investmentAmount: json['amount'] as String,
    );

Map<String, dynamic> _$$InvestmentImplToJson(_$InvestmentImpl instance) =>
    <String, dynamic>{
      'id': instance.cardId,
      'name': instance.cardName,
      'type': instance.cardType,
      'amount': instance.investmentAmount,
    };
