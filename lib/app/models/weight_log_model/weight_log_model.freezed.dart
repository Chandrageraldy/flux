// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weight_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeightLogModel _$WeightLogModelFromJson(Map<String, dynamic> json) {
  return _WeightLogModel.fromJson(json);
}

/// @nodoc
mixin _$WeightLogModel {
  int? get id => throw _privateConstructorUsedError;
  int? get weight => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this WeightLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeightLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeightLogModelCopyWith<WeightLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeightLogModelCopyWith<$Res> {
  factory $WeightLogModelCopyWith(
          WeightLogModel value, $Res Function(WeightLogModel) then) =
      _$WeightLogModelCopyWithImpl<$Res, WeightLogModel>;
  @useResult
  $Res call({int? id, int? weight, String? userId, DateTime? createdAt});
}

/// @nodoc
class _$WeightLogModelCopyWithImpl<$Res, $Val extends WeightLogModel>
    implements $WeightLogModelCopyWith<$Res> {
  _$WeightLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeightLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? weight = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeightLogModelImplCopyWith<$Res>
    implements $WeightLogModelCopyWith<$Res> {
  factory _$$WeightLogModelImplCopyWith(_$WeightLogModelImpl value,
          $Res Function(_$WeightLogModelImpl) then) =
      __$$WeightLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, int? weight, String? userId, DateTime? createdAt});
}

/// @nodoc
class __$$WeightLogModelImplCopyWithImpl<$Res>
    extends _$WeightLogModelCopyWithImpl<$Res, _$WeightLogModelImpl>
    implements _$$WeightLogModelImplCopyWith<$Res> {
  __$$WeightLogModelImplCopyWithImpl(
      _$WeightLogModelImpl _value, $Res Function(_$WeightLogModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeightLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? weight = freezed,
    Object? userId = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$WeightLogModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      weight: freezed == weight
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeightLogModelImpl implements _WeightLogModel {
  _$WeightLogModelImpl({this.id, this.weight, this.userId, this.createdAt});

  factory _$WeightLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeightLogModelImplFromJson(json);

  @override
  final int? id;
  @override
  final int? weight;
  @override
  final String? userId;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'WeightLogModel(id: $id, weight: $weight, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightLogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, weight, userId, createdAt);

  /// Create a copy of WeightLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeightLogModelImplCopyWith<_$WeightLogModelImpl> get copyWith =>
      __$$WeightLogModelImplCopyWithImpl<_$WeightLogModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeightLogModelImplToJson(
      this,
    );
  }
}

abstract class _WeightLogModel implements WeightLogModel {
  factory _WeightLogModel(
      {final int? id,
      final int? weight,
      final String? userId,
      final DateTime? createdAt}) = _$WeightLogModelImpl;

  factory _WeightLogModel.fromJson(Map<String, dynamic> json) =
      _$WeightLogModelImpl.fromJson;

  @override
  int? get id;
  @override
  int? get weight;
  @override
  String? get userId;
  @override
  DateTime? get createdAt;

  /// Create a copy of WeightLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeightLogModelImplCopyWith<_$WeightLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
