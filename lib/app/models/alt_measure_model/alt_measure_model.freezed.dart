// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alt_measure_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AltMeasureModel _$AltMeasureModelFromJson(Map<String, dynamic> json) {
  return _AltMeasureModel.fromJson(json);
}

/// @nodoc
mixin _$AltMeasureModel {
  @JsonKey(name: 'serving_weight')
  double? get servingWeight => throw _privateConstructorUsedError;
  String? get measure => throw _privateConstructorUsedError;
  int? get seq => throw _privateConstructorUsedError;
  int? get qty => throw _privateConstructorUsedError;

  /// Serializes this AltMeasureModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AltMeasureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AltMeasureModelCopyWith<AltMeasureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AltMeasureModelCopyWith<$Res> {
  factory $AltMeasureModelCopyWith(
          AltMeasureModel value, $Res Function(AltMeasureModel) then) =
      _$AltMeasureModelCopyWithImpl<$Res, AltMeasureModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'serving_weight') double? servingWeight,
      String? measure,
      int? seq,
      int? qty});
}

/// @nodoc
class _$AltMeasureModelCopyWithImpl<$Res, $Val extends AltMeasureModel>
    implements $AltMeasureModelCopyWith<$Res> {
  _$AltMeasureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AltMeasureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? servingWeight = freezed,
    Object? measure = freezed,
    Object? seq = freezed,
    Object? qty = freezed,
  }) {
    return _then(_value.copyWith(
      servingWeight: freezed == servingWeight
          ? _value.servingWeight
          : servingWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      measure: freezed == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AltMeasureModelImplCopyWith<$Res>
    implements $AltMeasureModelCopyWith<$Res> {
  factory _$$AltMeasureModelImplCopyWith(_$AltMeasureModelImpl value,
          $Res Function(_$AltMeasureModelImpl) then) =
      __$$AltMeasureModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'serving_weight') double? servingWeight,
      String? measure,
      int? seq,
      int? qty});
}

/// @nodoc
class __$$AltMeasureModelImplCopyWithImpl<$Res>
    extends _$AltMeasureModelCopyWithImpl<$Res, _$AltMeasureModelImpl>
    implements _$$AltMeasureModelImplCopyWith<$Res> {
  __$$AltMeasureModelImplCopyWithImpl(
      _$AltMeasureModelImpl _value, $Res Function(_$AltMeasureModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AltMeasureModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? servingWeight = freezed,
    Object? measure = freezed,
    Object? seq = freezed,
    Object? qty = freezed,
  }) {
    return _then(_$AltMeasureModelImpl(
      servingWeight: freezed == servingWeight
          ? _value.servingWeight
          : servingWeight // ignore: cast_nullable_to_non_nullable
              as double?,
      measure: freezed == measure
          ? _value.measure
          : measure // ignore: cast_nullable_to_non_nullable
              as String?,
      seq: freezed == seq
          ? _value.seq
          : seq // ignore: cast_nullable_to_non_nullable
              as int?,
      qty: freezed == qty
          ? _value.qty
          : qty // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AltMeasureModelImpl implements _AltMeasureModel {
  _$AltMeasureModelImpl(
      {@JsonKey(name: 'serving_weight') this.servingWeight,
      this.measure,
      this.seq,
      this.qty});

  factory _$AltMeasureModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AltMeasureModelImplFromJson(json);

  @override
  @JsonKey(name: 'serving_weight')
  final double? servingWeight;
  @override
  final String? measure;
  @override
  final int? seq;
  @override
  final int? qty;

  @override
  String toString() {
    return 'AltMeasureModel(servingWeight: $servingWeight, measure: $measure, seq: $seq, qty: $qty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AltMeasureModelImpl &&
            (identical(other.servingWeight, servingWeight) ||
                other.servingWeight == servingWeight) &&
            (identical(other.measure, measure) || other.measure == measure) &&
            (identical(other.seq, seq) || other.seq == seq) &&
            (identical(other.qty, qty) || other.qty == qty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, servingWeight, measure, seq, qty);

  /// Create a copy of AltMeasureModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AltMeasureModelImplCopyWith<_$AltMeasureModelImpl> get copyWith =>
      __$$AltMeasureModelImplCopyWithImpl<_$AltMeasureModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AltMeasureModelImplToJson(
      this,
    );
  }
}

abstract class _AltMeasureModel implements AltMeasureModel {
  factory _AltMeasureModel(
      {@JsonKey(name: 'serving_weight') final double? servingWeight,
      final String? measure,
      final int? seq,
      final int? qty}) = _$AltMeasureModelImpl;

  factory _AltMeasureModel.fromJson(Map<String, dynamic> json) =
      _$AltMeasureModelImpl.fromJson;

  @override
  @JsonKey(name: 'serving_weight')
  double? get servingWeight;
  @override
  String? get measure;
  @override
  int? get seq;
  @override
  int? get qty;

  /// Create a copy of AltMeasureModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AltMeasureModelImplCopyWith<_$AltMeasureModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
