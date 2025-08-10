// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_scan_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealScanResultModel _$MealScanResultModelFromJson(Map<String, dynamic> json) {
  return _MealScanResultModel.fromJson(json);
}

/// @nodoc
mixin _$MealScanResultModel {
  String? get foodName => throw _privateConstructorUsedError;
  double? get healthScore => throw _privateConstructorUsedError;
  String? get healthScoreDesc => throw _privateConstructorUsedError;
  double? get quantity => throw _privateConstructorUsedError;

  /// Serializes this MealScanResultModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealScanResultModelCopyWith<MealScanResultModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealScanResultModelCopyWith<$Res> {
  factory $MealScanResultModelCopyWith(
          MealScanResultModel value, $Res Function(MealScanResultModel) then) =
      _$MealScanResultModelCopyWithImpl<$Res, MealScanResultModel>;
  @useResult
  $Res call(
      {String? foodName,
      double? healthScore,
      String? healthScoreDesc,
      double? quantity});
}

/// @nodoc
class _$MealScanResultModelCopyWithImpl<$Res, $Val extends MealScanResultModel>
    implements $MealScanResultModelCopyWith<$Res> {
  _$MealScanResultModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodName = freezed,
    Object? healthScore = freezed,
    Object? healthScoreDesc = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_value.copyWith(
      foodName: freezed == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String?,
      healthScore: freezed == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as double?,
      healthScoreDesc: freezed == healthScoreDesc
          ? _value.healthScoreDesc
          : healthScoreDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealScanResultModelImplCopyWith<$Res>
    implements $MealScanResultModelCopyWith<$Res> {
  factory _$$MealScanResultModelImplCopyWith(_$MealScanResultModelImpl value,
          $Res Function(_$MealScanResultModelImpl) then) =
      __$$MealScanResultModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? foodName,
      double? healthScore,
      String? healthScoreDesc,
      double? quantity});
}

/// @nodoc
class __$$MealScanResultModelImplCopyWithImpl<$Res>
    extends _$MealScanResultModelCopyWithImpl<$Res, _$MealScanResultModelImpl>
    implements _$$MealScanResultModelImplCopyWith<$Res> {
  __$$MealScanResultModelImplCopyWithImpl(_$MealScanResultModelImpl _value,
      $Res Function(_$MealScanResultModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodName = freezed,
    Object? healthScore = freezed,
    Object? healthScoreDesc = freezed,
    Object? quantity = freezed,
  }) {
    return _then(_$MealScanResultModelImpl(
      foodName: freezed == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String?,
      healthScore: freezed == healthScore
          ? _value.healthScore
          : healthScore // ignore: cast_nullable_to_non_nullable
              as double?,
      healthScoreDesc: freezed == healthScoreDesc
          ? _value.healthScoreDesc
          : healthScoreDesc // ignore: cast_nullable_to_non_nullable
              as String?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealScanResultModelImpl implements _MealScanResultModel {
  _$MealScanResultModelImpl(
      {this.foodName, this.healthScore, this.healthScoreDesc, this.quantity});

  factory _$MealScanResultModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealScanResultModelImplFromJson(json);

  @override
  final String? foodName;
  @override
  final double? healthScore;
  @override
  final String? healthScoreDesc;
  @override
  final double? quantity;

  @override
  String toString() {
    return 'MealScanResultModel(foodName: $foodName, healthScore: $healthScore, healthScoreDesc: $healthScoreDesc, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealScanResultModelImpl &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.healthScore, healthScore) ||
                other.healthScore == healthScore) &&
            (identical(other.healthScoreDesc, healthScoreDesc) ||
                other.healthScoreDesc == healthScoreDesc) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, foodName, healthScore, healthScoreDesc, quantity);

  /// Create a copy of MealScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealScanResultModelImplCopyWith<_$MealScanResultModelImpl> get copyWith =>
      __$$MealScanResultModelImplCopyWithImpl<_$MealScanResultModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealScanResultModelImplToJson(
      this,
    );
  }
}

abstract class _MealScanResultModel implements MealScanResultModel {
  factory _MealScanResultModel(
      {final String? foodName,
      final double? healthScore,
      final String? healthScoreDesc,
      final double? quantity}) = _$MealScanResultModelImpl;

  factory _MealScanResultModel.fromJson(Map<String, dynamic> json) =
      _$MealScanResultModelImpl.fromJson;

  @override
  String? get foodName;
  @override
  double? get healthScore;
  @override
  String? get healthScoreDesc;
  @override
  double? get quantity;

  /// Create a copy of MealScanResultModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealScanResultModelImplCopyWith<_$MealScanResultModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
