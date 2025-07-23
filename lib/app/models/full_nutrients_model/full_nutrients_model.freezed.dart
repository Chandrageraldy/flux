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

FullNutrient _$FullNutrientFromJson(Map<String, dynamic> json) {
  return _FullNutrient.fromJson(json);
}

/// @nodoc
mixin _$FullNutrient {
  @JsonKey(name: 'attr_id')
  int? get attrId => throw _privateConstructorUsedError;
  double? get value => throw _privateConstructorUsedError;

  /// Serializes this FullNutrient to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FullNutrient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FullNutrientCopyWith<FullNutrient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FullNutrientCopyWith<$Res> {
  factory $FullNutrientCopyWith(
          FullNutrient value, $Res Function(FullNutrient) then) =
      _$FullNutrientCopyWithImpl<$Res, FullNutrient>;
  @useResult
  $Res call({@JsonKey(name: 'attr_id') int? attrId, double? value});
}

/// @nodoc
class _$FullNutrientCopyWithImpl<$Res, $Val extends FullNutrient>
    implements $FullNutrientCopyWith<$Res> {
  _$FullNutrientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FullNutrient
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
abstract class _$$FullNutrientImplCopyWith<$Res>
    implements $FullNutrientCopyWith<$Res> {
  factory _$$FullNutrientImplCopyWith(
          _$FullNutrientImpl value, $Res Function(_$FullNutrientImpl) then) =
      __$$FullNutrientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'attr_id') int? attrId, double? value});
}

/// @nodoc
class __$$FullNutrientImplCopyWithImpl<$Res>
    extends _$FullNutrientCopyWithImpl<$Res, _$FullNutrientImpl>
    implements _$$FullNutrientImplCopyWith<$Res> {
  __$$FullNutrientImplCopyWithImpl(
      _$FullNutrientImpl _value, $Res Function(_$FullNutrientImpl) _then)
      : super(_value, _then);

  /// Create a copy of FullNutrient
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? attrId = freezed,
    Object? value = freezed,
  }) {
    return _then(_$FullNutrientImpl(
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
class _$FullNutrientImpl implements _FullNutrient {
  _$FullNutrientImpl({@JsonKey(name: 'attr_id') this.attrId, this.value});

  factory _$FullNutrientImpl.fromJson(Map<String, dynamic> json) =>
      _$$FullNutrientImplFromJson(json);

  @override
  @JsonKey(name: 'attr_id')
  final int? attrId;
  @override
  final double? value;

  @override
  String toString() {
    return 'FullNutrient(attrId: $attrId, value: $value)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FullNutrientImpl &&
            (identical(other.attrId, attrId) || other.attrId == attrId) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, attrId, value);

  /// Create a copy of FullNutrient
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FullNutrientImplCopyWith<_$FullNutrientImpl> get copyWith =>
      __$$FullNutrientImplCopyWithImpl<_$FullNutrientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FullNutrientImplToJson(
      this,
    );
  }
}

abstract class _FullNutrient implements FullNutrient {
  factory _FullNutrient(
      {@JsonKey(name: 'attr_id') final int? attrId,
      final double? value}) = _$FullNutrientImpl;

  factory _FullNutrient.fromJson(Map<String, dynamic> json) =
      _$FullNutrientImpl.fromJson;

  @override
  @JsonKey(name: 'attr_id')
  int? get attrId;
  @override
  double? get value;

  /// Create a copy of FullNutrient
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FullNutrientImplCopyWith<_$FullNutrientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
