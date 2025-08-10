// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'full_nutrients_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FullNutrientsModel _$FullNutrientsModelFromJson(Map<String, dynamic> json) {
  return _FullNutrientsModel.fromJson(json);
}

/// @nodoc
mixin _$FullNutrientsModel {
  @JsonKey(name: 'attr_id')
  int? get attrId => throw _privateConstructorUsedError;
  double? get value => throw _privateConstructorUsedError;

  /// Serializes this FullNutrientsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FullNutrientsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FullNutrientsModelCopyWith<FullNutrientsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullNutrientsModelCopyWith<$Res> {
  factory $FullNutrientsModelCopyWith(
          FullNutrientsModel value, $Res Function(FullNutrientsModel) then) =
      _$FullNutrientsModelCopyWithImpl<$Res, FullNutrientsModel>;
  @useResult
  $Res call({@JsonKey(name: 'attr_id') int? attrId, double? value});
}

/// @nodoc
class _$FullNutrientsModelCopyWithImpl<$Res, $Val extends FullNutrientsModel>
    implements $FullNutrientsModelCopyWith<$Res> {
  _$FullNutrientsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FullNutrientsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attrId = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      attrId: freezed == attrId
          ? _value.attrId
          : attrId // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FullNutrientsModelImplCopyWith<$Res>
    implements $FullNutrientsModelCopyWith<$Res> {
  factory _$$FullNutrientsModelImplCopyWith(_$FullNutrientsModelImpl value,
          $Res Function(_$FullNutrientsModelImpl) then) =
      __$$FullNutrientsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'attr_id') int? attrId, double? value});
}

/// @nodoc
class __$$FullNutrientsModelImplCopyWithImpl<$Res>
    extends _$FullNutrientsModelCopyWithImpl<$Res, _$FullNutrientsModelImpl>
    implements _$$FullNutrientsModelImplCopyWith<$Res> {
  __$$FullNutrientsModelImplCopyWithImpl(_$FullNutrientsModelImpl _value,
      $Res Function(_$FullNutrientsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of FullNutrientsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attrId = freezed,
    Object? value = freezed,
  }) {
    return _then(_$FullNutrientsModelImpl(
      attrId: freezed == attrId
          ? _value.attrId
          : attrId // ignore: cast_nullable_to_non_nullable
              as int?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FullNutrientsModelImpl implements _FullNutrientsModel {
  _$FullNutrientsModelImpl({@JsonKey(name: 'attr_id') this.attrId, this.value});

  factory _$FullNutrientsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FullNutrientsModelImplFromJson(json);

  @override
  @JsonKey(name: 'attr_id')
  final int? attrId;
  @override
  final double? value;

  @override
  String toString() {
    return 'FullNutrientsModel(attrId: $attrId, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullNutrientsModelImpl &&
            (identical(other.attrId, attrId) || other.attrId == attrId) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, attrId, value);

  /// Create a copy of FullNutrientsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullNutrientsModelImplCopyWith<_$FullNutrientsModelImpl> get copyWith =>
      __$$FullNutrientsModelImplCopyWithImpl<_$FullNutrientsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FullNutrientsModelImplToJson(
      this,
    );
  }
}

abstract class _FullNutrientsModel implements FullNutrientsModel {
  factory _FullNutrientsModel(
      {@JsonKey(name: 'attr_id') final int? attrId,
      final double? value}) = _$FullNutrientsModelImpl;

  factory _FullNutrientsModel.fromJson(Map<String, dynamic> json) =
      _$FullNutrientsModelImpl.fromJson;

  @override
  @JsonKey(name: 'attr_id')
  int? get attrId;
  @override
  double? get value;

  /// Create a copy of FullNutrientsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullNutrientsModelImplCopyWith<_$FullNutrientsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
