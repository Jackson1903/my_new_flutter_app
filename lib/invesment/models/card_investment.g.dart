// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_investment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CardInvestmentImpl _$$CardInvestmentImplFromJson(Map<String, dynamic> json) =>
    _$CardInvestmentImpl(
      cardId: json['cardId'] as String,
      cardName: json['cardName'] as String,
      cardType: json['cardType'] as String,
      investmentAmount: (json['investmentAmount'] as num).toDouble(),
      createdAt:
          json['createdAt'] == null ? DateTime.now() : DateTime.parse(json['createdAt'] as String),
      isActive: json['isActive'] as bool? ?? false,
    );

Map<String, dynamic> _$$CardInvestmentImplToJson(_$CardInvestmentImpl instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'cardName': instance.cardName,
      'cardType': instance.cardType,
      'investmentAmount': instance.investmentAmount,
      'createdAt': instance.createdAt.toIso8601String(),
      'isActive': instance.isActive,
    };
