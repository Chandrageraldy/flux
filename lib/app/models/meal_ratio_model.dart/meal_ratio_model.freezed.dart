// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_ratio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MealRatioModel _$MealRatioModelFromJson(Map<String, dynamic> json) {
  return _MealRatioModel.fromJson(json);
}

/// @nodoc
mixin _$MealRatioModel {
  double? get calorieKcal => throw _privateConstructorUsedError; // kcal
  double? get proteinG => throw _privateConstructorUsedError; // g
  double? get fatG => throw _privateConstructorUsedError; // g
  double? get carbsG => throw _privateConstructorUsedError;

  /// Serializes this MealRatioModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealRatioModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealRatioModelCopyWith<MealRatioModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealRatioModelCopyWith<$Res> {
  factory $MealRatioModelCopyWith(
          MealRatioModel value, $Res Function(MealRatioModel) then) =
      _$MealRatioModelCopyWithImpl<$Res, MealRatioModel>;
  @useResult
  $Res call(
      {double? calorieKcal, double? proteinG, double? fatG, double? carbsG});
}

/// @nodoc
class _$MealRatioModelCopyWithImpl<$Res, $Val extends MealRatioModel>
    implements $MealRatioModelCopyWith<$Res> {
  _$MealRatioModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealRatioModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calorieKcal = freezed,
    Object? proteinG = freezed,
    Object? fatG = freezed,
    Object? carbsG = freezed,
  }) {
    return _then(_value.copyWith(
      calorieKcal: freezed == calorieKcal
          ? _value.calorieKcal
          : calorieKcal // ignore: cast_nullable_to_non_nullable
              as double?,
      proteinG: freezed == proteinG
          ? _value.proteinG
          : proteinG // ignore: cast_nullable_to_non_nullable
              as double?,
      fatG: freezed == fatG
          ? _value.fatG
          : fatG // ignore: cast_nullable_to_non_nullable
              as double?,
      carbsG: freezed == carbsG
          ? _value.carbsG
          : carbsG // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MealRatioModelImplCopyWith<$Res>
    implements $MealRatioModelCopyWith<$Res> {
  factory _$$MealRatioModelImplCopyWith(_$MealRatioModelImpl value,
          $Res Function(_$MealRatioModelImpl) then) =
      __$$MealRatioModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? calorieKcal, double? proteinG, double? fatG, double? carbsG});
}

/// @nodoc
class __$$MealRatioModelImplCopyWithImpl<$Res>
    extends _$MealRatioModelCopyWithImpl<$Res, _$MealRatioModelImpl>
    implements _$$MealRatioModelImplCopyWith<$Res> {
  __$$MealRatioModelImplCopyWithImpl(
      _$MealRatioModelImpl _value, $Res Function(_$MealRatioModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealRatioModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? calorieKcal = freezed,
    Object? proteinG = freezed,
    Object? fatG = freezed,
    Object? carbsG = freezed,
  }) {
    return _then(_$MealRatioModelImpl(
      calorieKcal: freezed == calorieKcal
          ? _value.calorieKcal
          : calorieKcal // ignore: cast_nullable_to_non_nullable
              as double?,
      proteinG: freezed == proteinG
          ? _value.proteinG
          : proteinG // ignore: cast_nullable_to_non_nullable
              as double?,
      fatG: freezed == fatG
          ? _value.fatG
          : fatG // ignore: cast_nullable_to_non_nullable
              as double?,
      carbsG: freezed == carbsG
          ? _value.carbsG
          : carbsG // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MealRatioModelImpl implements _MealRatioModel {
  _$MealRatioModelImpl(
      {this.calorieKcal, this.proteinG, this.fatG, this.carbsG});

  factory _$MealRatioModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealRatioModelImplFromJson(json);

  @override
  final double? calorieKcal;
// kcal
  @override
  final double? proteinG;
// g
  @override
  final double? fatG;
// g
  @override
  final double? carbsG;

  @override
  String toString() {
    return 'MealRatioModel(calorieKcal: $calorieKcal, proteinG: $proteinG, fatG: $fatG, carbsG: $carbsG)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealRatioModelImpl &&
            (identical(other.calorieKcal, calorieKcal) ||
                other.calorieKcal == calorieKcal) &&
            (identical(other.proteinG, proteinG) ||
                other.proteinG == proteinG) &&
            (identical(other.fatG, fatG) || other.fatG == fatG) &&
            (identical(other.carbsG, carbsG) || other.carbsG == carbsG));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, calorieKcal, proteinG, fatG, carbsG);

  /// Create a copy of MealRatioModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealRatioModelImplCopyWith<_$MealRatioModelImpl> get copyWith =>
      __$$MealRatioModelImplCopyWithImpl<_$MealRatioModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealRatioModelImplToJson(
      this,
    );
  }
}

abstract class _MealRatioModel implements MealRatioModel {
  factory _MealRatioModel(
      {final double? calorieKcal,
      final double? proteinG,
      final double? fatG,
      final double? carbsG}) = _$MealRatioModelImpl;

  factory _MealRatioModel.fromJson(Map<String, dynamic> json) =
      _$MealRatioModelImpl.fromJson;

  @override
  double? get calorieKcal; // kcal
  @override
  double? get proteinG; // g
  @override
  double? get fatG; // g
  @override
  double? get carbsG;

  /// Create a copy of MealRatioModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealRatioModelImplCopyWith<_$MealRatioModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
