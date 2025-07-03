// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_investment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CardInvestment _$CardInvestmentFromJson(Map<String, dynamic> json) {
  return _CardInvestment.fromJson(json);
}

/// @nodoc
mixin _$CardInvestment {
  String get cardId => throw _privateConstructorUsedError;
  String get cardName => throw _privateConstructorUsedError;
  String get cardType => throw _privateConstructorUsedError;
  double get investmentAmount => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;

  /// Serializes this CardInvestment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CardInvestment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CardInvestmentCopyWith<CardInvestment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardInvestmentCopyWith<$Res> {
  factory $CardInvestmentCopyWith(CardInvestment value, $Res Function(CardInvestment) then) =
      _$CardInvestmentCopyWithImpl<$Res, CardInvestment>;
  @useResult
  $Res call(
      {String cardId,
      String cardName,
      String cardType,
      double investmentAmount,
      DateTime createdAt,
      bool isActive});
}

/// @nodoc
class _$CardInvestmentCopyWithImpl<$Res, $Val extends CardInvestment>
    implements $CardInvestmentCopyWith<$Res> {
  _$CardInvestmentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CardInvestment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? cardName = null,
    Object? cardType = null,
    Object? investmentAmount = null,
    Object? createdAt = null,
    Object? isActive = null,
  }) {
    return _then(_value.copyWith(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      cardName: null == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      investmentAmount: null == investmentAmount
          ? _value.investmentAmount
          : investmentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CardInvestmentImplCopyWith<$Res> implements $CardInvestmentCopyWith<$Res> {
  factory _$$CardInvestmentImplCopyWith(
          _$CardInvestmentImpl value, $Res Function(_$CardInvestmentImpl) then) =
      __$$CardInvestmentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String cardId,
      String cardName,
      String cardType,
      double investmentAmount,
      DateTime createdAt,
      bool isActive});
}

/// @nodoc
class __$$CardInvestmentImplCopyWithImpl<$Res>
    extends _$CardInvestmentCopyWithImpl<$Res, _$CardInvestmentImpl>
    implements _$$CardInvestmentImplCopyWith<$Res> {
  __$$CardInvestmentImplCopyWithImpl(
      _$CardInvestmentImpl _value, $Res Function(_$CardInvestmentImpl) _then)
      : super(_value, _then);

  /// Create a copy of CardInvestment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardId = null,
    Object? cardName = null,
    Object? cardType = null,
    Object? investmentAmount = null,
    Object? createdAt = null,
    Object? isActive = null,
  }) {
    return _then(_$CardInvestmentImpl(
      cardId: null == cardId
          ? _value.cardId
          : cardId // ignore: cast_nullable_to_non_nullable
              as String,
      cardName: null == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String,
      cardType: null == cardType
          ? _value.cardType
          : cardType // ignore: cast_nullable_to_non_nullable
              as String,
      investmentAmount: null == investmentAmount
          ? _value.investmentAmount
          : investmentAmount // ignore: cast_nullable_to_non_nullable
              as double,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CardInvestmentImpl implements _CardInvestment {
  _$CardInvestmentImpl(
      {required this.cardId,
      required this.cardName,
      required this.cardType,
      required this.investmentAmount,
      DateTime? createdAt,
      this.isActive = false})
      : createdAt = createdAt ?? DateTime.now();

  factory _$CardInvestmentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CardInvestmentImplFromJson(json);

  @override
  final String cardId;
  @override
  final String cardName;
  @override
  final String cardType;
  @override
  final double investmentAmount;
  @override
  @JsonKey()
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isActive;

  @override
  String toString() {
    return 'CardInvestment(cardId: $cardId, cardName: $cardName, cardType: $cardType, investmentAmount: $investmentAmount, createdAt: $createdAt, isActive: $isActive)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CardInvestmentImpl &&
            (identical(other.cardId, cardId) || other.cardId == cardId) &&
            (identical(other.cardName, cardName) || other.cardName == cardName) &&
            (identical(other.cardType, cardType) || other.cardType == cardType) &&
            (identical(other.investmentAmount, investmentAmount) ||
                other.investmentAmount == investmentAmount) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.isActive, isActive) || other.isActive == isActive));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cardId, cardName, cardType, investmentAmount, createdAt, isActive);

  /// Create a copy of CardInvestment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CardInvestmentImplCopyWith<_$CardInvestmentImpl> get copyWith =>
      __$$CardInvestmentImplCopyWithImpl<_$CardInvestmentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CardInvestmentImplToJson(
      this,
    );
  }
}

abstract class _CardInvestment implements CardInvestment {
  factory _CardInvestment(
      {required final String cardId,
      required final String cardName,
      required final String cardType,
      required final double investmentAmount,
      final DateTime createdAt,
      final bool isActive}) = _$CardInvestmentImpl;

  factory _CardInvestment.fromJson(Map<String, dynamic> json) = _$CardInvestmentImpl.fromJson;

  @override
  String get cardId;
  @override
  String get cardName;
  @override
  String get cardType;
  @override
  double get investmentAmount;
  @override
  DateTime get createdAt;
  @override
  bool get isActive;

  /// Create a copy of CardInvestment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CardInvestmentImplCopyWith<_$CardInvestmentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
