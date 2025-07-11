// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InvestmentImpl _$$InvestmentImplFromJson(Map<String, dynamic> json) =>
    _$InvestmentImpl(
      cardId: json['cardId'] as String,
      cardName: json['cardName'] as String,
      cardType: json['cardType'] as String,
      investmentAmount: json['investmentAmount'] as String,
    );

Map<String, dynamic> _$$InvestmentImplToJson(_$InvestmentImpl instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardName': instance.cardName,
      'cardType': instance.cardType,
      'investmentAmount': instance.investmentAmount,
    };
