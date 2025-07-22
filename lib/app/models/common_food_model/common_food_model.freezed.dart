// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'common_food_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CommonFoodModel _$CommonFoodModelFromJson(Map<String, dynamic> json) {
  return _CommonFoodModel.fromJson(json);
}

/// @nodoc
mixin _$CommonFoodModel {
  @JsonKey(name: 'tag_id')
  String? get tagId => throw _privateConstructorUsedError;
  @JsonKey(name: 'food_name')
  String? get foodName => throw _privateConstructorUsedError;
  @JsonKey(name: 'nf_calories')
  int? get calorieKcal => throw _privateConstructorUsedError;
  @JsonKey(name: 'serving_qty')
  int? get servingQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'serving_unit')
  String? get servingUnit => throw _privateConstructorUsedError;

  /// Serializes this CommonFoodModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CommonFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommonFoodModelCopyWith<CommonFoodModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommonFoodModelCopyWith<$Res> {
  factory $CommonFoodModelCopyWith(
          CommonFoodModel value, $Res Function(CommonFoodModel) then) =
      _$CommonFoodModelCopyWithImpl<$Res, CommonFoodModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'tag_id') String? tagId,
      @JsonKey(name: 'food_name') String? foodName,
      @JsonKey(name: 'nf_calories') int? calorieKcal,
      @JsonKey(name: 'serving_qty') int? servingQty,
      @JsonKey(name: 'serving_unit') String? servingUnit});
}

/// @nodoc
class _$CommonFoodModelCopyWithImpl<$Res, $Val extends CommonFoodModel>
    implements $CommonFoodModelCopyWith<$Res> {
  _$CommonFoodModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CommonFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagId = freezed,
    Object? foodName = freezed,
    Object? calorieKcal = freezed,
    Object? servingQty = freezed,
    Object? servingUnit = freezed,
  }) {
    return _then(_value.copyWith(
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String?,
      foodName: freezed == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String?,
      calorieKcal: freezed == calorieKcal
          ? _value.calorieKcal
          : calorieKcal // ignore: cast_nullable_to_non_nullable
              as int?,
      servingQty: freezed == servingQty
          ? _value.servingQty
          : servingQty // ignore: cast_nullable_to_non_nullable
              as int?,
      servingUnit: freezed == servingUnit
          ? _value.servingUnit
          : servingUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommonFoodModelImplCopyWith<$Res>
    implements $CommonFoodModelCopyWith<$Res> {
  factory _$$CommonFoodModelImplCopyWith(_$CommonFoodModelImpl value,
          $Res Function(_$CommonFoodModelImpl) then) =
      __$$CommonFoodModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'tag_id') String? tagId,
      @JsonKey(name: 'food_name') String? foodName,
      @JsonKey(name: 'nf_calories') int? calorieKcal,
      @JsonKey(name: 'serving_qty') int? servingQty,
      @JsonKey(name: 'serving_unit') String? servingUnit});
}

/// @nodoc
class __$$CommonFoodModelImplCopyWithImpl<$Res>
    extends _$CommonFoodModelCopyWithImpl<$Res, _$CommonFoodModelImpl>
    implements _$$CommonFoodModelImplCopyWith<$Res> {
  __$$CommonFoodModelImplCopyWithImpl(
      _$CommonFoodModelImpl _value, $Res Function(_$CommonFoodModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of CommonFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tagId = freezed,
    Object? foodName = freezed,
    Object? calorieKcal = freezed,
    Object? servingQty = freezed,
    Object? servingUnit = freezed,
  }) {
    return _then(_$CommonFoodModelImpl(
      tagId: freezed == tagId
          ? _value.tagId
          : tagId // ignore: cast_nullable_to_non_nullable
              as String?,
      foodName: freezed == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String?,
      calorieKcal: freezed == calorieKcal
          ? _value.calorieKcal
          : calorieKcal // ignore: cast_nullable_to_non_nullable
              as int?,
      servingQty: freezed == servingQty
          ? _value.servingQty
          : servingQty // ignore: cast_nullable_to_non_nullable
              as int?,
      servingUnit: freezed == servingUnit
          ? _value.servingUnit
          : servingUnit // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommonFoodModelImpl implements _CommonFoodModel {
  const _$CommonFoodModelImpl(
      {@JsonKey(name: 'tag_id') this.tagId,
      @JsonKey(name: 'food_name') this.foodName,
      @JsonKey(name: 'nf_calories') this.calorieKcal,
      @JsonKey(name: 'serving_qty') this.servingQty,
      @JsonKey(name: 'serving_unit') this.servingUnit});

  factory _$CommonFoodModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommonFoodModelImplFromJson(json);

  @override
  @JsonKey(name: 'tag_id')
  final String? tagId;
  @override
  @JsonKey(name: 'food_name')
  final String? foodName;
  @override
  @JsonKey(name: 'nf_calories')
  final int? calorieKcal;
  @override
  @JsonKey(name: 'serving_qty')
  final int? servingQty;
  @override
  @JsonKey(name: 'serving_unit')
  final String? servingUnit;

  @override
  String toString() {
    return 'CommonFoodModel(tagId: $tagId, foodName: $foodName, calorieKcal: $calorieKcal, servingQty: $servingQty, servingUnit: $servingUnit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommonFoodModelImpl &&
            (identical(other.tagId, tagId) || other.tagId == tagId) &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.calorieKcal, calorieKcal) ||
                other.calorieKcal == calorieKcal) &&
            (identical(other.servingQty, servingQty) ||
                other.servingQty == servingQty) &&
            (identical(other.servingUnit, servingUnit) ||
                other.servingUnit == servingUnit));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, tagId, foodName, calorieKcal, servingQty, servingUnit);

  /// Create a copy of CommonFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommonFoodModelImplCopyWith<_$CommonFoodModelImpl> get copyWith =>
      __$$CommonFoodModelImplCopyWithImpl<_$CommonFoodModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommonFoodModelImplToJson(
      this,
    );
  }
}

abstract class _CommonFoodModel implements CommonFoodModel {
  const factory _CommonFoodModel(
          {@JsonKey(name: 'tag_id') final String? tagId,
          @JsonKey(name: 'food_name') final String? foodName,
          @JsonKey(name: 'nf_calories') final int? calorieKcal,
          @JsonKey(name: 'serving_qty') final int? servingQty,
          @JsonKey(name: 'serving_unit') final String? servingUnit}) =
      _$CommonFoodModelImpl;

  factory _CommonFoodModel.fromJson(Map<String, dynamic> json) =
      _$CommonFoodModelImpl.fromJson;

  @override
  @JsonKey(name: 'tag_id')
  String? get tagId;
  @override
  @JsonKey(name: 'food_name')
  String? get foodName;
  @override
  @JsonKey(name: 'nf_calories')
  int? get calorieKcal;
  @override
  @JsonKey(name: 'serving_qty')
  int? get servingQty;
  @override
  @JsonKey(name: 'serving_unit')
  String? get servingUnit;

  /// Create a copy of CommonFoodModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommonFoodModelImplCopyWith<_$CommonFoodModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
